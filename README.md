# Hugo Website - Vasilii Pustovoit

This is my personal website, converted from raw HTML to [Hugo](https://gohugo.io/) and managed with Nix flakes.

## Quick Start

### Option 1: Using Convenience Scripts

```bash
# Start development server
./serve.sh

# Build production site
./build.sh
```

### Option 2: Using Nix Flake

Enter the development shell with Hugo available:

```bash
nix develop
cd hugo-site
hugo server -D
```

Build the static site:

```bash
nix build
```

The built site will be in `./result/`

### Option 3: Using Hugo Directly

If you have Hugo installed:

```bash
cd hugo-site
hugo server -D  # Development server
hugo            # Production build
```

## Project Structure

```
.
├── flake.nix           # Nix flake configuration
├── build.sh            # Build convenience script
├── serve.sh            # Development server script
├── hugo-site/
│   ├── hugo.toml       # Hugo configuration
│   ├── content/        # Markdown content files
│   │   ├── about.md
│   │   ├── contact.md
│   │   ├── research.md
│   │   ├── research/   # Research subpages
│   │   └── blog/       # Blog posts
│   ├── layouts/        # Hugo templates
│   │   ├── _default/   # Default templates
│   │   ├── partials/   # Reusable template parts
│   │   ├── about/      # About page template
│   │   ├── contact/    # Contact page template
│   │   └── research/   # Research page template
│   ├── static/         # Static assets (CSS, JS, images, fonts)
│   └── public/         # Generated site (not in git)
└── *.html              # Original HTML files (kept for reference)
```

## Customization

### Editing Content

Edit markdown files in `hugo-site/content/`:
- `about.md` - About page
- `contact.md` - Contact information
- `research.md` - Research overview
- `research/*.md` - Research subpages (publications, code)
- `blog/science/*.md` - Science blog posts
- `blog/coding/*.md` - Coding blog posts
- `talks/*.md` - Your talks and presentations

### Editing Templates

Templates are in `hugo-site/layouts/`:
- `_default/baseof.html` - Base template for all pages
- `partials/header.html` - Header navigation
- `partials/footer.html` - Footer with social links
- `index.html` - Home page template
- Custom page templates in subdirectories

### Styling

CSS files are in `hugo-site/static/css/`:
- `style.css` - Main styles
- `mobile.css` - Mobile responsive styles

### Configuration

Edit `hugo-site/hugo.toml` to change:
- Site title and URL
- Author information
- Social media links
- Menu structure

## Deployment

### Build for Production

```bash
nix build
# Output is in ./result/
```

Or without Nix:

```bash
cd hugo-site
hugo --minify
# Output is in public/
```

### Deploy Options

The generated static site can be deployed to:
- GitHub Pages
- Netlify
- Vercel
- Any static hosting service
- Your own web server

Simply upload the contents of `public/` or `result/` to your hosting provider.

## Nix Flake Features

- **`nix develop`** - Enter development shell with Hugo
- **`nix build`** - Build production site
- **`nix run`** - Run Hugo directly
- **`nix flake check`** - Validate flake configuration

## Migration Notes

This site was migrated from raw HTML to Hugo, with the following conversions:
- HTML pages → Markdown content + Hugo templates
- Shared header/footer → Reusable partials
- Static assets → Hugo static directory
- Navigation → Hugo menu system in config

The original HTML files are kept in the repository root for reference.
