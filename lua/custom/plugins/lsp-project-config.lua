return {
  'neovim/nvim-lspconfig',
  opts = function()
    -- Function to detect project root and load project-specific config
    local function get_project_config(root_dir, config_files)
      for _, config_file in ipairs(config_files) do
        local config_path = root_dir .. '/' .. config_file
        if vim.fn.filereadable(config_path) == 1 then
          return config_path
        end
      end
      return nil
    end

    return {
      servers = {
        -- JSON LSP with project-specific schema detection
        jsonls = {
          settings = {
            json = {
              -- Automatically detect schema from project files
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
          on_new_config = function(config, root_dir)
            -- Look for project-specific JSON config
            local json_config = get_project_config(root_dir, { '.vscode/settings.json', 'package.json' })
            if json_config then
              -- Adjust settings based on project config
              config.settings.json.format = {
                enable = true,
              }
            end
          end,
        },
        
        -- TypeScript/JavaScript with project detection
        ts_ls = {
          on_new_config = function(config, root_dir)
            -- Detect if project uses specific config files
            local prettier_config = get_project_config(root_dir, { 
              '.prettierrc', 
              '.prettierrc.json', 
              '.prettierrc.js', 
              'prettier.config.js' 
            })
            
            if prettier_config then
              -- Disable LSP formatting in favor of prettier
              config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
                typescript = {
                  format = { enable = false },
                },
                javascript = {
                  format = { enable = false },
                },
              })
            end
          end,
        },
      },
    }
  end,
  dependencies = {
    'b0o/schemastore.nvim', -- JSON schemas
  },
}