local lspconfig = require 'lspconfig'

return {
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetypes = { "graphql", "typescript", "typescriptreact", "javascriptreact" },
  root_dir = lspconfig.util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*')
}
