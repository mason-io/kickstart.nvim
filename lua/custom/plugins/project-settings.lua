return {
  'tpope/vim-sleuth', -- Automatically detect indentation
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- vim-sleuth automatically detects indentation from existing files
    -- It works by analyzing the current buffer and similar files in the project
    
    -- Additional autocmd to apply project-specific settings
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = '*',
      callback = function()
        local root_dir = vim.fn.getcwd()
        
        -- Look for common project config files and apply settings
        local config_files = {
          { file = '.editorconfig', handler = 'editorconfig' },
          { file = '.prettierrc', handler = 'prettier' },
          { file = '.prettierrc.json', handler = 'prettier' },
          { file = 'package.json', handler = 'package_json' },
          { file = '.eslintrc.js', handler = 'eslint' },
          { file = '.eslintrc.json', handler = 'eslint' },
        }
        
        for _, config in ipairs(config_files) do
          local config_path = root_dir .. '/' .. config.file
          if vim.fn.filereadable(config_path) == 1 then
            -- Project config detected - rely on formatters to read it
            vim.g.project_config_detected = config.handler
            break
          end
        end
        
        -- Special handling for package.json
        if vim.fn.filereadable(root_dir .. '/package.json') == 1 then
          local ok, package_content = pcall(vim.fn.readfile, root_dir .. '/package.json')
          if ok then
            local package_str = table.concat(package_content, '\n')
            local json_ok, package_json = pcall(vim.fn.json_decode, package_str)
            
            if json_ok and package_json then
              -- Check for prettier config in package.json
              if package_json.prettier then
                vim.g.project_prettier_config = true
              end
              
              -- Check for specific dependencies that might indicate formatting preferences
              if package_json.devDependencies then
                if package_json.devDependencies.prettier then
                  vim.g.project_uses_prettier = true
                end
                if package_json.devDependencies.eslint then
                  vim.g.project_uses_eslint = true
                end
              end
            else
              -- Log warning but don't crash
              vim.notify('Warning: Failed to parse package.json in ' .. root_dir, vim.log.levels.WARN)
            end
          end
        end
      end,
    })
  end,
}