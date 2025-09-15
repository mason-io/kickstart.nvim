return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = { 'mason-org/mason.nvim' },
  opts = {
    ensure_installed = {
      -- Formatters that respect project config files
      'prettierd', -- Fast prettier daemon (respects .prettierrc)
      'prettier', -- Fallback formatter
      'stylua', -- Lua formatter (respects stylua.toml)
      'black', -- Python formatter (respects pyproject.toml)
      'ruff', -- Python linter/formatter (respects ruff.toml)
      'gofmt', -- Go formatter
      'rustfmt', -- Rust formatter (respects rustfmt.toml)
      
      -- LSP servers that can handle formatting
      'json-lsp', -- JSON language server
      'typescript-language-server', -- TypeScript/JavaScript LSP
      'css-lsp', -- CSS language server
      'html-lsp', -- HTML language server
      
      -- Linters that respect project config
      'eslint_d', -- Fast ESLint daemon (respects .eslintrc.*)
    },
    auto_update = false,
    run_on_start = true,
  },
}