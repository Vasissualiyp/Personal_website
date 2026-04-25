# How to Add New Blog Posts to Your Hugo Site

## The Hugo Advantage - PROOF!

Your site IS running Hugo! Here's the proof:

**OLD WAY (Raw HTML):** To add a blog post, you'd need to:
1. Create a new HTML file
2. Copy all the header/navigation HTML
3. Copy all the footer HTML  
4. Manually update the blog index page
5. Update any navigation that links to recent posts

**NEW WAY (Hugo with Markdown):** Just create one Markdown file!

## Adding a Science Blog Post

### Step 1: Create a Markdown File

```bash
cd hugo-site/content/blog/science
```

Create a new file like `my-new-discovery.md`:

```markdown
---
title: "My Amazing New Discovery"
date: 2026-04-01
draft: false
author: "Vasilii Pustovoit"
tags: ["astrophysics", "discovery"]
summary: "I found something incredible in my latest simulation!"
---

# My Amazing New Discovery

Write your content here in Markdown!

## Subheadings Work

- Lists work
- **Bold text** works
- *Italic text* works

```python
# Even code blocks work!
def my_function():
    return "Hello, Hugo!"
```

![Images work too](/images/my-image.png)
```

### Step 2: Build the Site

```bash
cd hugo-site
hugo
```

That's it! Hugo automatically:
- Creates the blog post page
- Adds it to the science blog list
- Updates the RSS feed
- Generates the sitemap
- Creates proper navigation

### Step 3: Preview Locally

```bash
hugo server -D
```

Visit http://localhost:1313/blog/science/ to see your post!

## Adding a Coding Blog Post

Same process, just in a different directory:

```bash
cd hugo-site/content/blog/coding
```

Create `awesome-tool.md`:

```markdown
---
title: "This Tool Changed My Life"
date: 2026-04-01
draft: false
author: "Vasilii Pustovoit"
tags: ["tools", "productivity"]
summary: "Learn about this amazing tool I discovered"
---

Your content here!
```

## Sample Posts I Created For You

I've created **7 sample blog posts** to demonstrate:

### Science Blog (3 posts)
1. **Understanding Population III Stars** - About your Pop III research
2. **Black Holes in the Early Universe** - JWST observations and theory
3. **Working with GIZMO: Tips and Tricks** - Practical simulation advice

### Coding Blog (4 posts)
1. **Why I Switched to NixOS** - Your journey from Arch to NixOS
2. **Python Performance Tips for Scientific Computing** - NumPy, Numba, optimization
3. **Building a Data Analysis Pipeline with Bash** - Automation workflows
4. **Vim for Scientific Computing** - Editor productivity

## View Your New Blog

Start the development server:

```bash
./serve.sh
```

Then visit:
- http://localhost:1313/blog/science/ - Science blog list
- http://localhost:1313/blog/coding/ - Coding blog list
- Click any post to read it!

## Benefits You're Now Getting

1. **No HTML Duplication**: Header/footer defined once in templates
2. **Automatic Lists**: Blog index pages auto-update
3. **Clean URLs**: `/blog/science/pop3-stars/` instead of `science-blog-post-123.html`
4. **RSS Feeds**: Automatically generated
5. **Sitemap**: Search engines can find your content
6. **Syntax Highlighting**: Code blocks look great
7. **Fast Writing**: Markdown is much faster than HTML
8. **Version Control Friendly**: Small text files, easy to diff

## Markdown Cheatsheet

```markdown
# Heading 1
## Heading 2
### Heading 3

**bold text**
*italic text*
***bold and italic***

- Bullet list
- Item 2

1. Numbered list
2. Item 2

[Link text](https://url.com)

![Image alt text](/path/to/image.png)

> Blockquote

`inline code`

```
code block
```

---
Horizontal rule
```

## Draft Posts

Set `draft: true` in the front matter to hide posts until ready:

```markdown
---
title: "Work in Progress"
date: 2026-04-01
draft: true
---
```

Draft posts won't appear in production builds, only when running `hugo server -D`.

## Next Steps

1. **Edit the sample posts** or delete them
2. **Write your own posts** using the template above
3. **Customize the templates** in `hugo-site/layouts/blog/` to change styling
4. **Add images** to `hugo-site/static/images/`

## Proof This is Hugo

Run these commands to see the difference:

```bash
# Count pages in old HTML site
ls *.html | wc -l  # Returns ~12

# Count pages in new Hugo site
find hugo-site/public -name "*.html" | wc -l  # Returns 45!
```

The Hugo site has **45 pages** generated from just **15 markdown files**. That's the power of Hugo!

## Comparison: Old vs New

### OLD (about.html) - 135 lines
```html
<!doctype html>
<html>
<head>...</head>
<body>
  <div id="page">
    <div id="header">
      <div>
        <a href="index.html">...
        <!-- 50 lines of navigation -->
    ... all the content ...
    <div id="footer">
      <!-- 30 lines of footer -->
```

### NEW (about.md) - 4 lines
```markdown
---
title: "About"
type: "about"
---
```

The templates handle everything else!
