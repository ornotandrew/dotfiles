local util = require("wraithy.util")

local black = require('lsp.efm.black')
local isort = require('lsp.efm.isort')
local pylint = require('lsp.efm.pylint')
local terraform = require('lsp.efm.terraform')
local eslint = require('lsp.efm.eslint')
local prettier = require('lsp.efm.prettier')

-- local js = { eslint, prettier }
local js = { prettier }

local languages = {
  python = { black, isort, pylint },
  javascript = js,
  javascriptreact = js,
  typescript = js,
  typescriptreact = js,
  tf = { terraform },
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
