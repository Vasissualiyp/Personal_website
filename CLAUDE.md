# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Development server (live reload, drafts visible)
./serve.sh
# or: cd hugo-site && hugo server -D

# Production build (output in hugo-site/public/)
./build.sh
# or: cd hugo-site && hugo

# Nix-based build (output in ./result/)
nix build

# Enter Nix dev shell with Hugo
nix develop
```

All `./build.sh` / `./serve.sh` scripts auto-detect whether Hugo is available on PATH or falls back to `nix-shell -p hugo`.

## Architecture

This is a **Hugo static site** (`hugo-site/`) converted from the original raw HTML files (still present at the repo root for reference).

### Content model (`hugo-site/content/`)

- `about.md`, `contact.md` — single pages with dedicated layout overrides
- `research/` — section with sub-pages (`publications.md`, `code.md`) and a `talks/` subsection
- `research/talks/*.md` — individual talk pages; frontmatter keys: `title`, `date`, `venue`, `image`, `pdf`, `summary`
- `blog/science/*.md`, `blog/coding/*.md` — blog posts split by category

### Layout hierarchy (`hugo-site/layouts/`)

- `_default/baseof.html` — root shell; loads `css/style.css`, `css/mobile.css`, `js/mobile.js`
- `partials/header.html` — nav driven entirely by `hugo.toml` `[menu]` entries (supports parent/child dropdown structure)
- `partials/footer.html` — social links from `hugo.toml` `[params]`
- Per-section overrides: `about/single.html`, `contact/single.html`, `research/section.html`, `research/single.html`, `blog/single.html`, `blog/list.html`, `talks/list.html`, `talks/single.html`

### Static assets (`hugo-site/static/`)

CSS, JS, fonts, and images live here and are copied verbatim into `public/` on build. The same files are duplicated in `hugo-site/public/` (generated output — do not edit directly).

### Configuration (`hugo-site/hugo.toml`)

Site URL, author info, social links (`[params]`), and the entire navigation menu (`[menu]`) are defined here. Adding a new top-level or dropdown menu entry only requires editing this file.

### Deployment

`pullscript.sh` runs `git pull origin master` every 4 hours — this is the live server's update mechanism. Push to `master` to deploy.

## Adding a new talk

1. Create `hugo-site/content/research/talks/<slug>.md` with frontmatter: `title`, `date`, `venue`, `image`, `pdf`, `summary`.
2. Add the PDF to `hugo-site/static/talks/`.
3. Add the thumbnail image to `hugo-site/static/images/initial/`.
