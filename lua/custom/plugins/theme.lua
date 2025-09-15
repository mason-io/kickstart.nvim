return {
  -- Option 1: Keep tokyonight but configure it to match your terminal
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'night', -- Choose: storm, moon, night, day
        transparent = true, -- Enable this to use terminal background
        terminal_colors = true, -- Configure terminal colors
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = 'transparent', -- style for sidebars, see below
          floats = 'transparent', -- style for floating windows
        },
        sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style
        hide_inactive_statusline = false, -- Enabling this option will hide inactive statuslines
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When true, section headers in the lualine theme will be bold
        
        -- You can override specific color groups to match your terminal
        on_colors = function(colors)
          -- Customize colors here to match your Warp theme
          -- Example: colors.bg = "#000000" -- Set background to pure black
        end,
        on_highlights = function(highlights, colors)
          -- Customize specific highlights to match your terminal
        end,
      })
      
      -- Load the colorscheme
      vim.cmd.colorscheme('tokyonight-night')
    end,
  },

  -- Option 2: Alternative themes that might match better
  -- Uncomment one of these if you prefer:
  
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup({
  --       flavour = 'mocha', -- latte, frappe, macchiato, mocha
  --       transparent_background = true,
  --       term_colors = true,
  --       styles = {
  --         comments = {},
  --         conditionals = {},
  --         loops = {},
  --         functions = {},
  --         keywords = {},
  --         strings = {},
  --         variables = {},
  --         numbers = {},
  --         booleans = {},
  --         properties = {},
  --         types = {},
  --       },
  --     })
  --     vim.cmd.colorscheme('catppuccin')
  --   end,
  -- },

  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   priority = 1000,
  --   config = function()
  --     require('rose-pine').setup({
  --       variant = 'moon', -- auto, main, moon, or dawn
  --       dark_variant = 'moon',
  --       bold_vert_split = false,
  --       dim_nc_background = false,
  --       disable_background = true, -- Use terminal background
  --       disable_float_background = true,
  --       disable_italics = true,
  --     })
  --     vim.cmd.colorscheme('rose-pine')
  --   end,
  -- },

  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   priority = 1000,
  --   config = function()
  --     require('gruvbox').setup({
  --       terminal_colors = true,
  --       undercurl = true,
  --       underline = true,
  --       bold = true,
  --       italic = {
  --         strings = false,
  --         emphasis = false,
  --         comments = false,
  --         operators = false,
  --         folds = false,
  --       },
  --       strikethrough = true,
  --       invert_selection = false,
  --       invert_signs = false,
  --       invert_tabline = false,
  --       invert_intend_guides = false,
  --       inverse = true,
  --       contrast = '', -- can be "hard", "soft" or empty string
  --       palette_overrides = {},
  --       overrides = {},
  --       dim_inactive = false,
  --       transparent_mode = true, -- Use terminal background
  --     })
  --     vim.cmd.colorscheme('gruvbox')
  --   end,
  -- },

  -- {
  --   'nordtheme/vim',
  --   priority = 1000,
  --   config = function()
  --     vim.g.nord_cursor_line_number_background = 1
  --     vim.g.nord_uniform_status_lines = 1
  --     vim.g.nord_bold_vertical_split_line = 1
  --     vim.g.nord_uniform_diff_background = 1
  --     vim.g.nord_italic = 0
  --     vim.g.nord_italic_comments = 0
  --     vim.cmd.colorscheme('nord')
  --   end,
  -- },
}