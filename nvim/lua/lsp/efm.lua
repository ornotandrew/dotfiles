local util = require("wraithy.util")

local prettier = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true,
}

-- local js = { eslint, prettier }
local js = { prettier }

local languages = {
  javascript = js,
  javascriptreact = js,
  typescript = js,
  typescriptreact = js,
  graphql = { prettier },
}

return {
  init_options = { documentFormatting = true },
  filetypes = util.keys(languages),
  settings = {
    rootMarkers = { ".git/" },
    languages = languages
  }
}
