-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
local vale_config = vim.fn.stdpath('config') .. '/vale/.vale.ini'

if vim.fn.filereadable(vale_config) == 1 then
  vim.env.VALE_CONFIG_PATH = vale_config
end

return {}
