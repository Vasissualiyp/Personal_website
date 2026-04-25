---
title: "Vim for Scientific Computing"
date: 2025-09-15
draft: false
author: "Vasilii Pustovoit"
tags: ["vim", "productivity", "tools"]
summary: "How I use Vim for everything from writing papers to editing simulation configs"
---

# Vim for Scientific Computing

Yes, I'm one of *those* people who uses Vim for everything. Here's why it works brilliantly for scientific computing.

## Why Vim?

1. **Available everywhere**: Every cluster, server, and system has vi/vim
2. **Keyboard-driven**: No mouse needed once you learn the bindings
3. **Lightning fast**: Even on huge files or over slow SSH connections
4. **Highly customizable**: Plugins for everything
5. **Integrated with terminal**: Switch between editor and shell seamlessly

## My Vim Setup for Science

### Essential Plugins

I use `vim-plug` to manage plugins:

```vim
call plug#begin('~/.vim/plugged')

" Language support
Plug 'lervag/vimtex'           " LaTeX editing
Plug 'vim-python/python-syntax' " Python syntax
Plug 'LnL7/vim-nix'            " Nix expressions

" Utilities
Plug 'scrooloose/nerdtree'     " File browser
Plug 'junegunn/fzf.vim'        " Fuzzy file finding
Plug 'tpope/vim-fugitive'      " Git integration
Plug 'dense-analysis/ale'      " Linting

call plug#end()
```

### Key Mappings

My `.vimrc` has these essential mappings:

```vim
" Set leader key
let mapleader = ","

" Quick save
nnoremap <leader>w :w<CR>

" Navigate splits easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Fuzzy file search
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Toggle file tree
nnoremap <leader>n :NERDTreeToggle<CR>
```

## Workflows

### Editing Simulation Configs

GIZMO's `Config.sh` is just a text file. I use Vim to:

```vim
" Search for a parameter
/MaxMemSize

" Comment/uncomment lines quickly
:s/^/#/        " Comment
:s/^#//        " Uncomment

" Visual block mode for bulk edits
Ctrl-v  " Enter visual block
j j j   " Select lines
I #     " Insert # at start
Esc     " Apply to all
```

### Writing Papers in LaTeX

VimTeX plugin makes LaTeX editing amazing:

- `\ll`: Compile document
- `\lv`: View PDF
- `\lc`: Clean auxiliary files
- Autocomplete citations and labels
- Syntax highlighting for math mode

### Analyzing Data

I often edit Python scripts while viewing results:

```vim
" In one terminal
:terminal python3 analyze.py

" Split screen
:vsplit results.dat

" Cycle between them
Ctrl-w w
```

### Editing Over SSH

When working on remote clusters:

```bash
# Edit files on remote system
ssh cluster 'vim /path/to/file'

# Or use scp + local vim
scp cluster:/path/to/file .
vim file
scp file cluster:/path/to/file
```

With `vim-fugitive`, I can commit changes while on the cluster.

## Productivity Tips

### 1. Marks for Quick Navigation
```vim
ma       " Set mark 'a'
'a       " Jump to mark 'a'
```

I mark important sections of my code to jump between them quickly.

### 2. Macros for Repetitive Tasks
```vim
qa       " Start recording macro in register 'a'
...      " Do stuff
q        " Stop recording
@a       " Replay macro
@@       " Replay last macro
```

Great for reformatting data files or adding repetitive code.

### 3. Search and Replace Across Files
```vim
:args **/*.py        " Add all Python files
:argdo %s/old/new/g  " Replace in all files
:argdo update        " Save all
```

### 4. Integrate with Make
```vim
:make
:copen   " Open quickfix window with errors
:cnext   " Jump to next error
```

## Learning Curve

I won't lie - Vim has a steep learning curve. But here's how I learned:

1. **Week 1**: Just use basic movement (hjkl) and insert mode
2. **Week 2**: Learn operators (d, c, y) and motions (w, b, $)
3. **Week 3**: Add visual mode and search/replace
4. **Month 2**: Gradually add plugins and custom keybindings
5. **After 6 months**: Muscle memory kicks in

Resources:
- `vimtutor` - built-in tutorial
- [Vim Adventures](https://vim-adventures.com/) - gamified learning
- [Practical Vim](https://pragprog.com/titles/dnvim2/practical-vim-second-edition/) - excellent book

## Alternatives

If Vim isn't your thing:
- **Neovim**: Vim's modern successor (what I actually use now)
- **Emacs**: The other classic (respect to Emacs users!)
- **VS Code**: Great if you prefer GUI with Vim keybindings extension

But give Vim a real try - your future self on a remote cluster will thank you!
