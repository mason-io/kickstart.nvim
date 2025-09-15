# Project-Specific Formatting Setup

This configuration now supports multiple approaches to respect project-specific formatting rules instead of hardcoded settings.

## How It Works

### 1. **EditorConfig Support** (Primary Method)
- Plugin: `gpanders/editorconfig.nvim`
- File: `lua/custom/plugins/editorconfig.lua`
- **What it does**: Automatically reads `.editorconfig` files in your project root and applies settings like:
  - `indent_style` (spaces vs tabs)
  - `indent_size` (2, 4, 8 spaces, etc.)
  - `end_of_line` (LF, CRLF)
  - `charset` (utf-8, etc.)
  - `trim_trailing_whitespace`
  - `insert_final_newline`

### 2. **Enhanced Formatter Configuration**
- File: `lua/custom/plugins/formatting.lua`
- **What it does**: 
  - Uses `prettierd/prettier` for JS/TS/JSON/CSS/HTML/Markdown
  - Automatically reads project config files like:
    - `.prettierrc`, `.prettierrc.json`, `prettier.config.js`
    - `package.json` (prettier field)
  - Uses `stylua` for Lua (reads `stylua.toml`, `.stylua.toml`)
  - Includes other language formatters that respect project configs

### 3. **Smart Project Detection**
- Plugin: `tpope/vim-sleuth`
- File: `lua/custom/plugins/project-settings.lua`
- **What it does**:
  - Automatically detects indentation from existing files
  - Scans for project config files and sets flags
  - Adapts behavior based on detected project type

### 4. **LSP-Based Formatting**
- File: `lua/custom/plugins/lsp-project-config.lua`
- **What it does**:
  - Configures LSP servers to respect project settings
  - Disables LSP formatting when dedicated formatters are present
  - Loads JSON schemas automatically

## Usage Examples

### For Your JSON Issue:
1. **Option A**: Create `.editorconfig` in project root:
   ```ini
   [*.json]
   indent_style = space
   indent_size = 2
   ```

2. **Option B**: Create `.prettierrc.json` in project root:
   ```json
   {
     "tabWidth": 2,
     "useTabs": false
   }
   ```

3. **Option C**: Add to `package.json`:
   ```json
   {
     "prettier": {
       "tabWidth": 2,
       "useTabs": false
     }
   }
   ```

### Priority Order:
1. **EditorConfig** (`.editorconfig`) - highest priority
2. **Formatter config** (`.prettierrc`, etc.)  
3. **vim-sleuth detection** (from existing files)
4. **Neovim defaults** (fallback)

## Installation Complete

The plugins are now installed and active. When you:
1. Open a file in a project with `.editorconfig` or formatter config files
2. The appropriate settings will be automatically detected and applied
3. Format-on-save will use the project's preferred settings

## Testing It Works

1. Create a test project:
   ```bash
   mkdir /tmp/test-project
   cd /tmp/test-project
   echo '{"test": "value"}' > test.json
   ```

2. Create `.editorconfig`:
   ```ini
   [*.json]
   indent_style = space
   indent_size = 2
   ```

3. Open in Neovim:
   ```bash
   nvim test.json
   ```

4. Format the file (`<leader>f`) - should use 2 spaces!

## Supported Project Config Files

- **EditorConfig**: `.editorconfig`
- **Prettier**: `.prettierrc`, `.prettierrc.json`, `.prettierrc.js`, `prettier.config.js`, `package.json`
- **ESLint**: `.eslintrc.js`, `.eslintrc.json`
- **Stylua**: `stylua.toml`, `.stylua.toml`
- **Python**: `pyproject.toml`, `setup.cfg`
- **Go**: Standard `go fmt` behavior
- **Rust**: `rustfmt.toml`

Your original issue with JSON files formatting to 8 spaces should now be resolved by creating appropriate project configuration files!