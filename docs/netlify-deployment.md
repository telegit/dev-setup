# Netlify Deployment Guide

## First-Time Setup

### 1. Create a Netlify account
Go to netlify.com → sign up with GitHub account (`telegit`).

### 2. Import the repo
- Dashboard → **Add new site** → **Import an existing project**
- Choose GitHub → select the repo
- Build settings (auto-detected):
  - Build command: `npm run build`
  - Publish directory: `dist`
- Click **Deploy site**

### 3. Get a shareable preview URL
Netlify assigns a random URL within ~1 minute:
`https://fluffy-pup-abc123.netlify.app`

Share this with the client for content review.

### 4. Rename the preview URL (optional)
Site settings → **Domain management** → edit the subdomain.
Example: `studio-woof-preview.netlify.app`

---

## Contact Form

No configuration needed. Netlify detects `data-netlify="true"` on the form at build time.

- Submissions appear in: **Netlify dashboard → Forms**
- To email notifications: **Forms → Form notifications → Add notification → Email**

---

## Google Sheets Form Catcher (optional)

To mirror form submissions into a Google Sheet the client owns (on top of
Netlify Forms, no third-party service): Netlify fires an outgoing webhook on
each submission to a Google Apps Script web app bound to the client's Sheet,
which appends a row.

Canonical script + full setup/troubleshooting doc:
[`client-site-template/docs/google-sheets-catcher.md`](https://github.com/telegit/client-site-template/blob/main/docs/google-sheets-catcher.md)
(and `sheets-catcher.gs` alongside it — copy both into the client repo's
`docs/` and adjust the `TABS` mapping to that site's form name(s)).

**The one gotcha that always bites:** when deploying the Apps Script web app,
*Who has access* must be **Anyone** — not "Anyone with Google account".
Netlify's webhook call is unauthenticated, so anything less bounces it with a
Google Drive "You need access" page (HTTP 403) before `doPost` ever runs.
Symptom: Netlify shows the submission fine (email notifications work), the
Sheet stays empty, and the Apps Script Executions log is completely empty —
nothing to debug because the code never ran. Test the `/exec` URL directly
with `docs/test-sheets-catcher.sh <url>` from the template repo to catch this
in seconds, bypassing Netlify entirely.

---

## Ongoing Deploys

Every `git push` to `master` triggers an automatic redeploy. Nothing else needed.

To check deploy status: Netlify dashboard → **Deploys**

---

## Custom Domain (when ready to go live)

Option A — Point nameservers to Netlify (recommended):
1. Netlify → **Domain management** → **Add a domain**
2. Follow prompts to get Netlify nameservers
3. Update nameservers at your registrar
4. SSL provisions automatically via Let's Encrypt (~24hrs)

Option B — Add a CNAME record at your registrar pointing to the Netlify subdomain.

**After cutting over, verify it:** `check-dns-cutover.sh <domain>
[expected-mx-substring]` (repo root here, and in `client-site-template/docs/`)
checks the A record, HTTPS + redirects, SSL cert validity, and page content
in one shot — pass the second arg for a domain with email on it (Google
Workspace, Microsoft 365, etc.) to confirm the MX record survived the
cutover:

```bash
./check-dns-cutover.sh example.com "mail.protection.outlook.com"
```

---

## Notes

- Free tier supports unlimited deploys, 100GB bandwidth/month, 300 build minutes/month
- Form submissions: 100/month free, then paid
- Add `netlify.toml` to the repo root to lock in build settings (optional but clean)
