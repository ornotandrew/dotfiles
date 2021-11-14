local util = require("wraithy.util")

local black = require('wraithy.efm.black')
local isort = require('wraithy.efm.isort')
local pylint = require('wraithy.efm.pylint')
local terraform = require('wraithy.efm.terraform')
local eslint = require('wraithy.efm.eslint')
local prettier = require('wraithy.efm.prettier')
local stylelint = require('wraithy.efm.stylelint')
local sqlfluff = require('wraithy.efm.sqlfluff')

local languages = {
  python = {black, isort, pylint},
  javascript = {eslint},
  typescript = {eslint},
  typescriptreact = {eslint},
  css = {stylelint},
  tf = {terraform},
  -- sql = {sqlfluff}
}

return {
  init_options = {documentFormatting = true},
  filetypes = util.keys(languages),
  settings = {
    rootMarkers = {".git/"},
    languages = languages
  }
}
