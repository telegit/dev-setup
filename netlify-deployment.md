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

---

## Notes

- Free tier supports unlimited deploys, 100GB bandwidth/month, 300 build minutes/month
- Form submissions: 100/month free, then paid
- Add `netlify.toml` to the repo root to lock in build settings (optional but clean)
