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
  override_resolved_capabilities = {
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
