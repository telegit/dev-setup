# Small Business Astro Template

## Overview
- Reusable static site template for small business clients
- Stack: Astro + Bootstrap 5 (CDN) — no backend required
- Hosting: Netlify (free tier) with built-in form handling
- Template repo: `github.com/telegit/studio-woof` (private)

---

## New Project Workflow

### 1. Use the GitHub template
Go to `github.com/telegit/studio-woof` → click **"Use this template"** → name the new repo → set to private.

### 2. Clone and install
```bash
git clone git@github.com:telegit/<new-repo>.git
cd <new-repo>
npm install
```

### 3. Configure the site
Edit the single config file — this is the only file that needs to change per business:
```
src/config/site.ts
```

Fields to fill in:
- `business` — name, tagline, email
- `locations` — array of locations, each with address, city, phone, hours
- `brand` — primary color, secondary color, accent color
- `nav` — navigation links
- `hero` — headline, subheading, CTA button
- `features` — 4-column trust strip on the homepage
- `services` — standard service menu with size-based pricing
- `luxuryServices` — optional luxury/add-on packages (delete array if not needed)
- `social` — Instagram and Facebook URLs (leave blank to hide)
- `meta` — SEO description

### 4. Run locally
```bash
npm run dev
# Opens at http://localhost:4321
```

### 5. Build to verify
```bash
npm run build
```

---

## Project Structure

```
src/
  config/site.ts        ← edit this per business
  layouts/Base.astro    ← HTML shell, Bootstrap, theme vars, LocalBusiness schema
  components/
    Navbar.astro
    Hero.astro
    ServiceCard.astro
    ContactForm.astro   ← includes breed/age fields for analytics
    Footer.astro        ← social icons via Bootstrap Icons
  pages/
    index.astro         ← Home
    services.astro      ← Services & Pricing + luxury upsell
    luxury.astro        ← Luxury Add-On Packages (optional, delete if unused)
    contact.astro       ← Contact
public/
  images/               ← drop logo and photos here
```

---

## Netlify Deployment

### Connect repo
1. Log in to Netlify → **Add new site** → **Import from Git**
2. Select the repo
3. Build settings are auto-detected:
   - Build command: `npm run build`
   - Publish directory: `dist`

### Netlify Forms
The contact form works automatically — no configuration needed. Netlify detects the `data-netlify="true"` attribute at build time. Submissions appear in the Netlify dashboard under **Forms**.

To forward submissions to email: Netlify dashboard → **Forms** → **Form notifications**.

### Custom domain
Point the domain's nameservers to Netlify, or add a CNAME record to the Netlify subdomain. Netlify provisions SSL automatically via Let's Encrypt.

---

## Adding a Business-Specific Field to the Contact Form

Edit `src/components/ContactForm.astro` and add a field inside the `<div class="row g-3">` block:

```html
<div class="col-12">
  <label for="custom" class="form-label fw-medium">Field Label</label>
  <input type="text" id="custom" name="custom" class="form-control" placeholder="..." />
</div>
```

---

## Branding Tips

Colors are set in `site.ts` under `brand.primary`, `brand.secondary`, and `brand.accent`. These flow into Bootstrap's CSS custom properties automatically — no other files need to change.

To use a custom Google Font, update the font import URL and `fontFamily` value in `site.ts`:
```ts
fontFamily: "'Playfair Display', serif",
```
Then update the Google Fonts `<link>` in `src/layouts/Base.astro` to match.

---

## SEO — LocalBusiness Schema

JSON-LD structured data is auto-generated in `Base.astro` from `site.ts`. One `LocalBusiness` entry is output per location. No manual editing needed — just keep `locations` up to date in `site.ts`.

To verify: paste the live URL into [Google's Rich Results Test](https://search.google.com/test/rich-results).

---

## Contact Form Fields

The form captures: name, email, phone (optional), dog breed (optional), dog age (optional), message. Fields are sent to Netlify Forms automatically. Add or remove optional fields in `src/components/ContactForm.astro`.

---

## First Instance
- **Studio Woof** — dog grooming business
- Repo: `github.com/telegit/studio-woof`
- Real branding/content to be swapped in once provided by client
