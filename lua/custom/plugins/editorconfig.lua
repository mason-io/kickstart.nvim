return {
  'gpanders/editorconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- EditorConfig will automatically apply settings from .editorconfig files
    -- This includes indent_style, indent_size, end_of_line, etc.
  end,
}