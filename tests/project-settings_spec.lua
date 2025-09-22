-- Test suite for project-settings plugin
describe("project-settings", function()
  local function create_test_package_json(content)
    local temp_file = vim.fn.tempname()
    vim.fn.writefile(vim.split(content, '\n'), temp_file)
    return temp_file
  end

  describe("JSON parsing", function()
    it("should handle valid package.json", function()
      local valid_json = '{\n  "name": "test-project",\n  "devDependencies": {\n    "prettier": "^2.0.0",\n    "eslint": "^8.0.0"\n  }\n}'
      
      -- Test the JSON parsing logic directly
      local package_str = table.concat(vim.split(valid_json, '\n'), '\n')
      local json_ok, package_json = pcall(vim.fn.json_decode, package_str)
      
      assert.is_true(json_ok)
      assert.is_not_nil(package_json)
      assert.are.equal("test-project", package_json.name)
      assert.is_not_nil(package_json.devDependencies)
      assert.is_not_nil(package_json.devDependencies.prettier)
    end)

    it("should gracefully handle malformed JSON", function()
      local malformed_json = '{\n  "name": "dgui2",\n  "version": "0.0.0",\n  "license": "MIT",\n  "scripts": {\n    "preinstall": "node ../dgui/scripts/check-node-npm-versions.js",\n    "nx": "nx",\n    "start": "nx serve",\n    "build": "nx build",\n    "test-data": "node --expo'
      
      -- Test with the malformed JSON from the error
      local package_str = table.concat(vim.split(malformed_json, '\n'), '\n')
      local json_ok, package_json = pcall(vim.fn.json_decode, package_str)
      
      -- Should fail gracefully
      assert.is_false(json_ok)
      assert.is_nil(package_json)
    end)

    it("should handle empty or truncated files", function()
      local empty_json = ""
      local package_str = table.concat(vim.split(empty_json, '\n'), '\n')
      local json_ok, package_json = pcall(vim.fn.json_decode, package_str)
      
      assert.is_false(json_ok)
    end)
  end)
end)