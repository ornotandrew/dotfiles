local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

local M = {}

M.set_leader_map = function(key, fn)
  vim.keymap.set(
    'n',
    '<leader>' .. key,
    fn,
    { noremap = true }
  )
end

M.find_files = function(extra_options)
  return function()
    local opts = {
      previewer = false,
      layout_config = { width = 120 }
    }
    for k, v in pairs(extra_options or {}) do opts[k] = v end
    require('telescope.builtin').find_files(themes.get_dropdown(opts))
  end
end

M.lsp_references = function()
  builtin.lsp_references(themes.get_dropdown({ layout_config = { width = 120 } }))
end

return M
