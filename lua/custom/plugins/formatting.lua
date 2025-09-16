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
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      python = { 'ruff_format', 'black', stop_after_first = true },
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