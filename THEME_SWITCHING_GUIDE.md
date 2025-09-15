# Neovim Theme Configuration Guide

This guide helps you match your Neovim theme to your Warp terminal theme.

## 🚀 Quick Setup

1. **Run the theme detector:**
   ```bash
   ./warp-theme-detector.sh
   ```

2. **Edit the theme configuration:**
   ```bash
   nvim lua/custom/plugins/theme.lua
   ```

3. **Restart Neovim to see changes:**
   ```bash
   nvim
   ```

## 🎨 Available Theme Options

Your `lua/custom/plugins/theme.lua` contains several pre-configured options:

### Option 1: Tokyo Night (Default)
- **Best for**: Dark Warp themes, modern terminals
- **Variants**: `night`, `storm`, `moon`, `day`
- **Features**: Transparent background support, excellent syntax highlighting

```lua
-- Already active - edit to customize
style = 'night',           -- or 'storm', 'moon', 'day'
transparent = true,        -- Use terminal background
terminal_colors = true,    -- Match terminal colors
```

### Option 2: Catppuccin
- **Best for**: Pastel color schemes, modern aesthetic
- **Variants**: `latte`, `frappe`, `macchiato`, `mocha`

To enable:
1. Uncomment the Catppuccin section in `theme.lua`
2. Comment out the Tokyo Night section
3. Restart Neovim

### Option 3: Rose Pine
- **Best for**: Elegant, minimal themes
- **Variants**: `main`, `moon`, `dawn`

### Option 4: Gruvbox
- **Best for**: Retro, warm color schemes
- **Variants**: `hard`, `soft`, or default contrast

### Option 5: Nord
- **Best for**: Cool, arctic-inspired color schemes
- **Features**: Clean, minimal aesthetic

## 🔧 Customization Options

### Transparency (Recommended)
Use your terminal's background instead of theme background:

```lua
transparent = true,              -- Tokyo Night
transparent_background = true,   -- Catppuccin
disable_background = true,       -- Rose Pine
transparent_mode = true,         -- Gruvbox
```

### Terminal Color Integration
Make Neovim colors match your terminal:

```lua
terminal_colors = true,    -- Tokyo Night, Gruvbox
term_colors = true,        -- Catppuccin
```

### Custom Color Overrides
Fine-tune colors to match your Warp theme exactly:

```lua
on_colors = function(colors)
  -- Override specific colors
  -- colors.bg = "#1a1b26"        -- Background
  -- colors.fg = "#c0caf5"        -- Foreground
  -- colors.blue = "#7aa2f7"      -- Blue accent
end,
```

## 🎯 Matching Common Warp Themes

### Warp Dark → Tokyo Night
```lua
{
  'folke/tokyonight.nvim',
  config = function()
    require('tokyonight').setup({
      style = 'night',
      transparent = true,
      terminal_colors = true,
    })
    vim.cmd.colorscheme('tokyonight-night')
  end,
}
```

### Warp Light → Tokyo Night Day
```lua
style = 'day',
transparent = false,  -- Light themes usually need background
```

### Dracula Terminal → Custom Setup
```lua
-- Add dracula theme
{
  'Mofiqul/dracula.nvim',
  config = function()
    local dracula = require('dracula')
    dracula.setup({
      transparent_bg = true,
      italic_comment = false,
    })
    vim.cmd.colorscheme('dracula')
  end,
}
```

### One Dark → Custom Setup
```lua
{
  'navarasu/onedark.nvim',
  config = function()
    require('onedark').setup({
      style = 'dark',  -- dark, darker, cool, deep, warm, warmer
      transparent = true,
      term_colors = true,
    })
    vim.cmd.colorscheme('onedark')
  end,
}
```

## 🛠 Advanced Customization

### Method 1: Color Function Override
```lua
on_colors = function(colors)
  -- Match your terminal's exact colors
  colors.bg = "#000000"           -- Pure black background
  colors.bg_dark = "#000000"      -- Darker background
  colors.fg = "#ffffff"           -- White text
  colors.comment = "#6272a4"      -- Comment color
  -- Add more color overrides as needed
end,
```

### Method 2: Highlight Override
```lua
on_highlights = function(highlights, colors)
  -- Override specific syntax highlighting
  highlights.Function = { fg = colors.blue, bold = true }
  highlights.String = { fg = colors.green }
  highlights.Comment = { fg = colors.comment, italic = false }
end,
```

### Method 3: Terminal Color Detection
If you want to extract colors from your current terminal:

```bash
# Get background color (requires special terminal support)
echo -ne '\e]11;?\a'

# Or use a color picker tool
# brew install colorpicker-sketchybar  # macOS
```

## 📋 Theme Switching Commands

Once configured, you can switch themes in Neovim:

```vim
" List all available colorschemes
:Telescope colorscheme

" Switch directly
:colorscheme tokyonight-night
:colorscheme catppuccin
:colorscheme rose-pine
:colorscheme gruvbox
:colorscheme nord
```

## 🔍 Troubleshooting

### Colors look wrong?
1. Check your terminal supports true color: `echo $COLORTERM` should show `truecolor`
2. Enable true color in Neovim: Add `vim.o.termguicolors = true` to your config
3. Try transparent mode: Set `transparent = true` in your theme config

### Theme not loading?
1. Restart Neovim completely
2. Run `:Lazy sync` to ensure plugins are installed
3. Check for errors: `:checkhealth`

### Want to match exactly?
1. Use transparent mode to inherit terminal colors
2. Override specific colors using `on_colors` function
3. Take screenshots and adjust incrementally

## 💡 Pro Tips

1. **Use transparent backgrounds** - Let your terminal theme shine through
2. **Disable italics** - `italic = false` for better readability
3. **Match your statusline** - The mini.statusline will adapt to your theme
4. **Test with different file types** - Open `.js`, `.py`, `.md` files to see syntax highlighting
5. **Use `:hi` command** - See current highlight groups and their colors

## 🎪 Theme Gallery

Run these commands to preview themes quickly:

```bash
# Preview all themes
nvim -c 'Telescope colorscheme'

# Test with a sample file
echo "function hello() { console.log('world'); }" > test.js
nvim test.js -c 'Telescope colorscheme'
```

Your Neovim theme should now seamlessly blend with your Warp terminal! 🎉