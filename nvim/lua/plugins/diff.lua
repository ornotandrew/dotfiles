return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    local minidiff = require('mini.diff')
    minidiff.setup({
      source = minidiff.gen_source.none()
    })
  end
}
