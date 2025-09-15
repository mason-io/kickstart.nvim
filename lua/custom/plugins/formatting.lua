return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable format_on_save for certain filetypes
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      jsonc = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      scss = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      markdown = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
      python = { { 'ruff_format', 'black' } },
      go = { 'gofmt' },
      rust = { 'rustfmt' },
    },
    formatters = {
      -- Prettier will automatically read project config files:
      -- .prettierrc, .prettierrc.json, prettier.config.js, etc.
      prettier = {
        -- This ensures prettier uses project-specific config
        args = function()
          return {
            '--stdin-filepath',
            vim.api.nvim_buf_get_name(0),
          }
        end,
      },
      prettierd = {
        -- prettierd also respects project config automatically
        env = {
          -- Force prettierd to respect local config
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.prettierrc.json',
        },
      },
      -- Stylua will read stylua.toml or .stylua.toml
      stylua = {
        -- These args tell stylua to search for config files
        args = { '--search-parent-directories', '--stdin-filepath', '$FILENAME', '-' },
      },
    },
  },
}