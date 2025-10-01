return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local function set_toggleterm_highlights()
        -- Use a darker panel background so toggleterm splits stand out
        local panel_bg = '#1f2233'
        local border = '#3b4261'

        vim.api.nvim_set_hl(0, 'ToggleTermNormal', { bg = panel_bg })
        vim.api.nvim_set_hl(0, 'ToggleTermNormalFloat', { bg = panel_bg })
        vim.api.nvim_set_hl(0, 'ToggleTermBorder', { fg = border, bg = panel_bg })
      end

      set_toggleterm_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', {
        desc = 'Reapply toggleterm highlight overrides when the colorscheme changes',
        callback = set_toggleterm_highlights,
      })

      require('toggleterm').setup {
        -- Always place the default terminal in a bottom split for predictable layout
        direction = 'horizontal',
        highlights = {
          Normal = { link = 'ToggleTermNormal' },
          NormalFloat = { link = 'ToggleTermNormalFloat' },
          FloatBorder = { link = 'ToggleTermBorder' },
        },
      }

      local Terminal = require('toggleterm.terminal').Terminal
      local codex = Terminal:new {
        cmd = 'codex chat',
        direction = 'horizontal',
        close_on_exit = false,
        hidden = true,
      }

      vim.keymap.set('n', '<leader>cc', function()
        codex:toggle()
      end, { desc = 'Toggle Codex chat' })
    end,
  },
}
