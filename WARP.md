# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a **kickstart.nvim** configuration - a single-file, heavily documented Neovim starter configuration that serves as a learning tool and foundation for personal customization. Unlike a full distribution, kickstart.nvim is designed to be understood completely and modified according to individual needs.

## Essential Commands

### Starting Neovim
```bash
# Open Neovim
nvim

# Open with directory browser
nvim .

# Open with clean config (no plugins)
nvim --clean

# Open specific file
nvim filename.lua
```

### Plugin Management (Lazy.nvim)
```vim
" Open Lazy plugin manager
:Lazy

" Sync/install plugins
:Lazy sync

" Update plugins
:Lazy update

" View plugin status
:Lazy home

" Profile startup time
:Lazy profile

" View plugin logs
:Lazy log
```

### Code Formatting
```vim
" Format current buffer (LSP)
:lua vim.lsp.buf.format()

" Format with specific formatter
:ConformInfo
```

```bash
# Format Lua files with stylua
stylua .

# Check formatting without changing files
stylua --check .
```

### Health Checks & Diagnostics
```vim
" Check overall Neovim health
:checkhealth

" Check kickstart-specific health
:checkhealth kickstart

" Open Mason installer for LSPs/tools
:Mason

" Check LSP status
:LspInfo

" View current diagnostics
:lua vim.diagnostic.open_float()
```

### Debugging (DAP)
```vim
" Start/continue debugging
:DapContinue

" Toggle debug UI
:DapToggleUI

" Toggle breakpoint
:DapToggleBreakpoint

" Step into/over/out
:DapStepInto
:DapStepOver
:DapStepOut
```

## Architecture Overview

### Single-File Structure (`init.lua`)
The configuration is organized in a single `init.lua` file with these main sections:

1. **Leader Key Setup** - Space as leader key
2. **Core Options** - Editor behavior (line numbers, clipboard, etc.)
3. **Basic Keymaps** - Essential navigation and utility mappings
4. **Autocommands** - Automated behaviors (highlight on yank, etc.)
5. **Lazy.nvim Bootstrap** - Plugin manager installation
6. **Plugin Specifications** - All plugin configurations in one place

### Plugin Management (Lazy.nvim)
- **Automatic Installation** - Plugins are auto-installed on first run
- **Lazy Loading** - Plugins load on demand for faster startup
- **Lockfile** - `lazy-lock.json` pins exact plugin versions
- **Modular Loading** - Supports external plugin files via `require()`

### LSP & Tool Management (Mason)
The configuration uses Mason for automatic tool installation:

1. **LSP Servers** - Language servers (lua_ls, ts_ls, etc.)
2. **Formatters** - Code formatters (stylua, prettier, etc.)  
3. **Linters** - Code linters (eslint, luacheck, etc.)
4. **Debug Adapters** - Debuggers (delve for Go, node-debug2, etc.)

Mason automatically installs and manages these tools in Neovim's data directory.

### Key Plugin Categories

#### Core Functionality
- **lazy.nvim** - Plugin manager
- **mason.nvim** - External tool installer
- **nvim-lspconfig** - LSP client configuration

#### Editing & Navigation
- **telescope.nvim** - Fuzzy finder for files, grep, symbols
- **nvim-treesitter** - Syntax highlighting and text objects
- **blink.cmp** - Autocompletion engine
- **mini.nvim** - Collection of small utilities (surround, statusline, etc.)

#### Language Support
- **conform.nvim** - Code formatting
- **nvim-dap** - Debug Adapter Protocol support
- **lazydev.nvim** - Lua development for Neovim configs

#### Git Integration
- **gitsigns.nvim** - Git signs in gutter + git operations

#### UI Enhancements
- **tokyonight.nvim** - Color scheme
- **which-key.nvim** - Keymap hints
- **todo-comments.nvim** - Highlight TODO/FIXME comments

### Optional Modules (`lua/kickstart/plugins/`)
Additional plugins can be enabled by uncommenting require statements:

- **debug.lua** - DAP debugging setup (Go-focused)
- **indent_line.lua** - Indentation guides
- **lint.lua** - Linting integration
- **autopairs.lua** - Auto-close brackets/quotes
- **neo-tree.lua** - File explorer
- **gitsigns.lua** - Extended git integration

### Custom Plugin Directory (`lua/custom/plugins/`)
Personal plugins and overrides go in the custom directory:
- Files are automatically loaded via `{ import = 'custom.plugins' }`
- Currently includes `typescript.lua` with typescript-tools.nvim
- Add new `.lua` files here for additional plugins

## Key Mappings & Workflows

### Core Keymaps (Space Leader)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>sh` | `:Telescope help_tags` | Search help documentation |
| `<leader>sf` | `:Telescope find_files` | Find files |
| `<leader>sg` | `:Telescope live_grep` | Live grep search |
| `<leader>sw` | `:Telescope grep_string` | Search current word |
| `<leader>sd` | `:Telescope diagnostics` | Search diagnostics |
| `<leader>sr` | `:Telescope resume` | Resume last search |
| `<leader>/` | `:Telescope current_buffer_fuzzy_find` | Search in current buffer |
| `<leader><leader>` | `:Telescope buffers` | Switch between buffers |

### LSP Keymaps (when LSP is active)
| Key | Action | Description |
|-----|---------|-------------|
| `grn` | `vim.lsp.buf.rename` | Rename symbol |
| `gra` | `vim.lsp.buf.code_action` | Code actions |
| `grr` | `telescope.lsp_references` | Find references |
| `grd` | `telescope.lsp_definitions` | Go to definition |
| `gri` | `telescope.lsp_implementations` | Go to implementation |
| `grt` | `telescope.lsp_type_definitions` | Go to type definition |
| `gO` | `telescope.lsp_document_symbols` | Document symbols |
| `gW` | `telescope.lsp_dynamic_workspace_symbols` | Workspace symbols |

### Debugging Keymaps (F-keys)
| Key | Action | Description |
|-----|---------|-------------|
| `<F5>` | `dap.continue` | Start/continue debugging |
| `<F1>` | `dap.step_into` | Step into |
| `<F2>` | `dap.step_over` | Step over |
| `<F3>` | `dap.step_out` | Step out |
| `<F7>` | `dapui.toggle` | Toggle debug UI |
| `<leader>b` | `dap.toggle_breakpoint` | Toggle breakpoint |

### Window Navigation
| Key | Action | Description |
|-----|---------|-------------|
| `<C-h>` | Focus left window | Move cursor left |
| `<C-l>` | Focus right window | Move cursor right |
| `<C-j>` | Focus lower window | Move cursor down |
| `<C-k>` | Focus upper window | Move cursor up |

### Common Development Workflows

#### 1. Finding and Opening Files
```
<leader>sf → type filename → Enter → file opens
<leader>sg → type search term → Enter → jump to match
<leader>/ → search within current file
<leader><leader> → switch between open buffers
```

#### 2. Working with LSP
```
Open file → LSP auto-attaches → grr (references) → grd (definition)
Make changes → <leader>f (format) → gra (code actions if needed)
```

#### 3. Adding a New Plugin
```lua
-- Edit init.lua, add to the require('lazy').setup({ ... }) table:
{
  'author/plugin-name',
  config = function()
    require('plugin-name').setup({})
  end,
}
```
Then run `:Lazy sync` and restart Neovim.

#### 4. Debugging Session
```
Set breakpoint: <leader>b
Start debugging: <F5>
Step through: <F1>/<F2>/<F3>
View variables: <F7> (toggle UI)
Continue: <F5>
```

## Customization Notes

### Adding Language Support
1. Add LSP server to the `servers` table in `init.lua`
2. Add formatter to `formatters_by_ft` in conform.nvim config
3. Run `:Mason` to install tools if not auto-installed
4. Add debug adapter to mason-nvim-dap `ensure_installed` if needed

### Styling Configuration
- **Font**: Set `vim.g.have_nerd_font = true` if using a Nerd Font
- **Theme**: Change `vim.cmd.colorscheme` call to use different tokyonight variant
- **Statusline**: Configure `mini.statusline` or replace with another statusline plugin

### Plugin Management
- **Disable plugins**: Comment out entries in the lazy.nvim setup table
- **Update lockfile**: Run `:Lazy update` then commit `lazy-lock.json` changes  
- **Custom configs**: Override plugin settings in their respective config functions

## Development Commands Reference

### Quick Actions
```bash
# Check configuration health
nvim --headless -c 'checkhealth kickstart' -c 'quit'

# Update all plugins
nvim --headless -c 'Lazy! sync' -c 'quit'

# Format all Lua files
stylua .

# Run basic Lua syntax check
luac -p init.lua
```

### Troubleshooting
```vim
" Debug plugin loading issues
:Lazy log

" Check LSP attachment
:LspInfo

" View all keymaps
:map
:nmap
:imap

" Check autocommands
:autocmd

" Reload configuration
:source %
```

---

*For more detailed information, read through the extensively commented `init.lua` file and see `:help kickstart.nvim`.*