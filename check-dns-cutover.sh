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
set -uo pipefail

DOMAIN="${1:?Usage: $0 <domain> [expected-mx-substring]}"
EXPECT_MX="${2:-}"
FAIL=0

section() { echo; echo "== $1 =="; }

section "A record"
dig +short "$DOMAIN" A

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
MX=$(dig +short "$DOMAIN" MX)
echo "$MX"
if [ -n "$EXPECT_MX" ]; then
  if echo "$MX" | grep -q "$EXPECT_MX"; then
    echo "OK: MX still contains '$EXPECT_MX'"
  else
    echo "FAIL: MX does not contain expected '$EXPECT_MX' -- email may be broken"
    FAIL=1
  fi
fi

echo
if [ "$FAIL" -eq 0 ]; then
  echo "All checks passed."
else
  echo "One or more checks FAILED -- see above."
  exit 1
fi
