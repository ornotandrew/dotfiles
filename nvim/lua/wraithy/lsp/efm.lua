local util = require("wraithy.util")

local black = require('wraithy.efm.black')
local isort = require('wraithy.efm.isort')
local pylint = require('wraithy.efm.pylint')
local terraform = require('wraithy.efm.terraform')
local eslint = require('wraithy.efm.eslint')
local prettier = require('wraithy.efm.prettier')

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
