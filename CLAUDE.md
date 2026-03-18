# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. All configuration is written in Lua.

## Architecture

**Entry point:** `init.lua` requires six modules in order:
1. `config.lazy` — bootstraps lazy.nvim and sets leader keys (`<Space>` / `\`)
2. `utils` — utility functions (project title, emoji picker), exposed via `_G.jamie_utils`
3. `options` — editor settings
4. `keymaps` — all custom keybindings
5. `lsp` — LSP client setup and none-ls formatters
6. `theme` — colorscheme (`lunaperche`)

**Plugin definitions:** all plugins and their `config`/`opts` are declared in `lua/plugins/plugins.lua` as a single lazy.nvim spec table.

**Local overrides:** `lua/jamie_local/color_overrides.lua` maps specific repo paths to emoji characters for the terminal title. This file is gitignored-style personal content — don't modify it unless the user asks.

## Key Plugins

- **claude-code.nvim** — AI assistant (`<C-_>` toggle, vertical split)
- **nvim-lspconfig + none-ls** — LSP clients; Python formatters: Black + isort (run on save)
- **nvim-cmp** — autocompletion with LSP, buffer, path, and cmdline sources
- **telescope.nvim** — fuzzy finder (`<leader>ff`, `<leader>fg`, `<C-P>`, `<C-G>`)
- **nvim-tree.lua** — file explorer (auto-opens on VimEnter)
- **nvim-treesitter** — syntax: javascript, typescript, python, html, css, lua
- **toggleterm.nvim** — terminal (`<C-\>` toggle)
- **nvim-tidal** — TidalCycles live coding (`<leader>te` eval block, `<leader>ts` start)
- **bufferline.nvim** — buffer tabs with underline indicator

## LSP Configuration (`lua/lsp.lua`)

Configured servers: `pyright`, `ts_ls`, `hls` (Haskell), `lua_ls`, `jsonls`, `rust_analyzer` (only when `JAMIE_USES_RUST=TRUE` env var is set).

Format on save is wired up in the `LspAttach` autocmd via `vim.lsp.buf.format()`.

## Installation Dependencies

From `install.sh`:
```bash
sudo apt install xclip
pip install pyright black isort
npm install -g typescript typescript-language-server
npm i -g vscode-langservers-extracted
```

## Notable Patterns

- **Filetype overrides** in `options.lua`: `.py.j2` / `.sql.j2` → `jinja2`; `.tidal` → `haskell`
- **Rust LSP** is opt-in via environment variable (`JAMIE_USES_RUST=TRUE`)
- **Project emoji** uses a deterministic hash over the cwd path as fallback when no explicit mapping exists in `jamie_local/color_overrides.lua`
- **Completion sort priority** in nvim-cmp is customized to rank `Variable` kind higher
