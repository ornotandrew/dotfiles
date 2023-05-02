local M = {}

function M.lsp_status_indicator()
  local clients = vim.lsp.buf_get_clients(0)
  print(vim.inspect(clients[0]))
end

return M
