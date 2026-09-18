#!/usr/bin/env bash
# Sanity-check a domain right after pointing it at Netlify (or verifying it
# stayed healthy afterward). Usage:
#   ./check-dns-cutover.sh <domain> [expected-mx-substring]
#
# The optional second arg lets you assert email routing wasn't clobbered by
# the cutover, e.g. a Microsoft 365 domain:
#   ./check-dns-cutover.sh example.com "mail.protection.outlook.com"
#
# Everything here is read-only (dig/curl/openssl) -- safe to re-run anytime.
#
# DNS lookups go straight to a public resolver (8.8.8.8) rather than the
# local machine's default -- right after a fix, your own resolver may still
# be serving a cached pre-fix answer for up to its TTL, which reads as a
# false failure (or, worse, a false pass of a since-reverted record). Google
# picks it up close to immediately, so it's a much more honest "is this
# actually live" check than whatever happens to be cached locally.
set -uo pipefail

RESOLVER=8.8.8.8
DOMAIN="${1:?Usage: $0 <domain> [expected-mx-substring]}"
EXPECT_MX="${2:-}"
FAIL=0

section() { echo; echo "== $1 =="; }

section "A record"
dig @"$RESOLVER" +short "$DOMAIN" A

section "HTTPS response"
CODE=$(curl -s -o /dev/null -w '%{http_code}' "https://$DOMAIN/")
SERVER=$(curl -sI "https://$DOMAIN/" | grep -i '^server:' | tr -d '\r')
echo "HTTP $CODE, $SERVER"
if [ "$CODE" != "200" ]; then
  echo "FAIL: expected 200"
  FAIL=1
fi
if ! echo "$SERVER" | grep -qi netlify; then
  echo "NOTE: server header doesn't say Netlify -- check this isn't still the old host"
fi

section "HTTP -> HTTPS redirect"
curl -sI "http://$DOMAIN/" | head -1

section "www <-> apex redirect"
curl -sI "https://www.$DOMAIN/" | head -1

section "SSL certificate"
echo | openssl s_client -connect "$DOMAIN:443" -servername "$DOMAIN" 2>/dev/null \
  | openssl x509 -noout -dates -subject 2>/dev/null || echo "FAIL: couldn't read certificate"

section "Page content sanity"
TITLE=$(curl -s "https://$DOMAIN/" | grep -o '<title>[^<]*</title>')
echo "$TITLE"
[ -z "$TITLE" ] && { echo "FAIL: no <title> found -- is this really the site?"; FAIL=1; }

section "MX / email records (should usually be untouched by a site DNS cutover)"
MX=$(dig @"$RESOLVER" +short "$DOMAIN" MX)
echo "$MX"
if [ -z "$MX" ]; then
  echo "NOTE: no MX records -- fine if this domain doesn't receive email"
else
  # Resolve each exchange, not just pattern-match the text. Migrating a DNS
  # provider commonly mangles MX records: e.g. pasting a source registrar's
  # combined "0 exchange.example.com" display value into a field that only
  # wants the exchange bakes a literal space into the hostname. The record
  # still *looks* right and a plain grep on it (like this script used to do)
  # still matches -- but the exchange no longer resolves, so mail bounces.
  # Actually resolving each one catches that regardless of what specifically
  # went wrong with the syntax.
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    EXCHANGE=$(echo "$line" | awk '{print $NF}' | sed 's/\.$//')
    RESOLVED=$(dig @"$RESOLVER" +short "$EXCHANGE" A)
    if [ -z "$RESOLVED" ]; then
      echo "FAIL: MX exchange '$EXCHANGE' (from '$line') does not resolve -- mail to this record will bounce"
      FAIL=1
    else
      echo "OK: '$EXCHANGE' resolves ($(echo "$RESOLVED" | tr '\n' ' ' | sed 's/ $//'))"
    fi
  done <<< "$MX"

  if [ -n "$EXPECT_MX" ]; then
    if echo "$MX" | grep -q "$EXPECT_MX"; then
      echo "OK: MX contains expected '$EXPECT_MX'"
    else
      echo "FAIL: MX does not contain expected '$EXPECT_MX' -- email may be broken"
      FAIL=1
    fi
  fi
fi

echo
if [ "$FAIL" -eq 0 ]; then
  echo "All checks passed."
else
  echo "One or more checks FAILED -- see above."
  exit 1
fi
