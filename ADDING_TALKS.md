# How to Add New Talks

Your talks section is now managed by Hugo! Here's how to add new talks.

## Adding a New Talk

### Step 1: Create a Markdown File

```bash
cd hugo-site/content/talks
```

Create a file like `my-new-talk.md`:

```markdown
---
title: "My Amazing Talk Title"
date: 2026-04-01
venue: "Conference Name"
image: "/images/my-talk-image.png"
pdf: "/talks/my-talk.pdf"
github: "https://github.com/username/repo"
summary: "Brief description of the talk"
---

## Venue Name

**Date:** April 1, 2026  
**Venue:** Conference Name  
**Title:** My Amazing Talk Title

### Abstract

Your full abstract goes here. You can write as much as you want in Markdown!

### Key Points

- Point 1
- Point 2
- Point 3

### Resources

The resources will be automatically generated from the front matter!
```

### Step 2: Add Your Materials

If you have a PDF or slides:

```bash
# Copy PDF to static/talks/
cp my-talk.pdf hugo-site/static/talks/

# Copy images to static/images/
cp my-image.png hugo-site/static/images/
```

### Step 3: Build

```bash
./build.sh
```

That's it! Hugo automatically:
- Creates the talk page
- Adds it to the talks list (sorted by date)
- Generates proper links to PDF/GitHub
- Creates navigation

## Front Matter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `title` | Yes | Talk title |
| `date` | Yes | Talk date (YYYY-MM-DD) |
| `venue` | Yes | Conference/venue name |
| `image` | No | Path to image (e.g., `/images/talk.png`) |
| `pdf` | No | Path to PDF (e.g., `/talks/slides.pdf`) |
| `github` | No | GitHub URL for code/materials |
| `slides` | No | Path to online slides |
| `summary` | Yes | Short description for list view |

## Example: Your Existing Talks

I've migrated all 8 of your talks:

1. **Reproducible Astrophysics with Nix** (Aug 2025)
2. **Beyond the First Light** (Jun 2025)
3. **Chessmology: 5D Chess** (Feb 2025)
4. **Pop III Star Formation** (Feb 2025)
5. **MUSIC Code Overview** (Mar 2024)
6. **Simulating First Objects** (Nov 2023)
7. **Formation of First Stars** (Nov 2023)
8. **GPT4 for Astrophysics** (Jul 2023)

## View Your Talks

```bash
./serve.sh
```

Visit:
- **http://localhost:1313/talks/** - All talks listed by date
- Click any talk to see the full page

## Comparison: Old vs New

### OLD way (talks.html):
- 156 lines of HTML
- Manually copy header/footer for each talk
- Update talks list by hand
- Hard to maintain chronological order

### NEW way (Hugo):
- 1 markdown file per talk (~20 lines)
- Automatic sorting by date
- Single template for all talks
- Just add a file and rebuild!

## Tips

1. **Images**: Put images in `static/images/` and reference as `/images/filename.png`
2. **PDFs**: Put PDFs in `static/talks/` and reference as `/talks/filename.pdf`
3. **Dates**: Use YYYY-MM-DD format for proper sorting
4. **Drafts**: Add `draft: true` to hide talks until ready

## File Locations

```
hugo-site/
├── content/talks/          # Your talk markdown files
│   ├── _index.md          # Talks page intro
│   ├── nix2025.md         # Individual talk
│   └── casca2025.md       # Individual talk
├── static/talks/          # PDFs and talk materials
│   └── CASCA2025.pdf
├── static/images/         # Talk images
└── layouts/talks/         # Templates (don't edit unless styling)
    ├── list.html          # Talks list page
    └── single.html        # Individual talk page
```

Much easier than managing HTML files! 🎉
