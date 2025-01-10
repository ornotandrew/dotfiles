local util = require 'lspconfig/util'

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.uri, 'react/index.d.ts') == nil
end

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim",
    preferences = {
      importModuleSpecifierPreference = "non-relative",
      quotePreference = "single",
      includeInlayParameterNameHints = 'literals', -- 'none' | 'literals' | 'all'
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = false,
      includeInlayVariableTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayEnumMemberValueHints = true,
    }
  },
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  override_server_capabilities = {
    document_formatting = false
  },
  handlers = {
    ['textDocument/definition'] = function(err, method, result, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = filter(result, filterReactDTS)
        print(filtered_result)
        return vim.lsp.handlers['textDocument/definition'](err, method, filtered_result, ...)
      end

      vim.lsp.handlers['textDocument/definition'](err, method, result, ...)
    end
  }
}
