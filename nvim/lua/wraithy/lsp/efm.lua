local util = require("wraithy.util")

local black = require('wraithy.efm.black')
local isort = require('wraithy.efm.isort')
local pylint = require('wraithy.efm.pylint')
local terraform = require('wraithy.efm.terraform')
local eslint = require('wraithy.efm.eslint')

local languages = {
  python = {black, isort, pylint},
  javascript = {eslint},
  typescript = {eslint},
  tf = {terraform}
}

return {
    init_options = {documentFormatting = true},
    filetypes = util.keys(languages),
    settings = {
      rootMarkers = {".git/"},
      languages = languages
    }
  }
