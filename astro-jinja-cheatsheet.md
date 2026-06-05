# Astro Cheat Sheet (for Jinja/Python devs)

## Mental Model

| Jinja (Flask/Django)             | Astro                                      |
|----------------------------------|--------------------------------------------|
| `{% extends "base.html" %}`      | Wrap page in a layout component `<Base>`   |
| `{% block content %}`            | `<slot />` inside the layout file          |
| `{% include "navbar.html" %}`    | `import Navbar from '../components/Navbar.astro'` then `<Navbar />` |
| `{{ variable }}`                 | `{variable}`                               |
| `{% for item in items %}`        | `{items.map(item => <div>{item.name}</div>)}` |
| `{% if condition %}`             | `{condition && <div>...</div>}`            |
| Template vars passed from view   | Frontmatter `---` block at top of file     |

## Frontmatter = your "view logic"

Logic lives in the `---` fenced block at the top — runs at build time on the server.

```astro
---
import { site } from '../config/site';
const featured = site.services.filter(s => s.featured);
---

<h1>{site.business.name}</h1>
{featured.map(s => <p>{s.name}</p>)}
```

## Conditionals

```astro
{condition && <p>Shows if true</p>}
{condition ? <p>True</p> : <p>False</p>}
```

## Loops

```astro
{items.map(item => (
  <div class="card">
    <h3>{item.name}</h3>
    <p>{item.description}</p>
  </div>
))}
```

## Layout / Slot (like extends + block)

**layouts/Base.astro**
```astro
---
const { title } = Astro.props;
---
<html>
  <head><title>{title}</title></head>
  <body>
    <slot />  <!-- page content goes here -->
  </body>
</html>
```

**pages/index.astro**
```astro
---
import Base from '../layouts/Base.astro';
---
<Base title="Home">
  <h1>Hello world</h1>
</Base>
```

## Passing props to components (like macro arguments)

```astro
<!-- calling it -->
<ServiceCard name="Bath" price="$35" />

<!-- ServiceCard.astro -->
---
const { name, price } = Astro.props;
---
<div>{name} — {price}</div>
```

## Styles are scoped by default

```astro
<p class="intro">Hello</p>

<style>
  /* only applies to THIS component */
  .intro { color: blue; }
</style>
```

## Key differences from Jinja

- No template inheritance via strings — use component composition instead
- Filters like `{{ price | upper }}` become JS methods: `{price.toUpperCase()}`
- Static by default — renders to HTML at build time, no JS sent to browser unless you add `<script>` or a framework (React, Vue, etc.)
- File-based routing — `src/pages/services.astro` → `/services`
