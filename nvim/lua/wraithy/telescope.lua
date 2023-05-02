local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

local M = {}

local function find_files(extra_options)
  return function()
    local opts = {
      previewer = false,
      layout_config = { width = 120 }
    }
    for k, v in pairs(extra_options or {}) do opts[k] = v end
    builtin.find_files(themes.get_dropdown(opts))
  end
end

M.find_files = find_files()
M.find_files_shorten_path = find_files({ path_display = { 'shorten' } })
M.find_config_files = find_files({ cwd = '~/.config/nvim/' })
M.grep_string_fuzzy = function() builtin.grep_string() end
M.grep_string_exact = builtin.live_grep
M.buffers = builtin.buffers
M.help_tags = function() builtin.help_tags(themes.get_dropdown({ layout_config = { width = 120 } })) end
M.lsp_references = function() builtin.lsp_references(themes.get_dropdown({ layout_config = { width = 120 } })) end
M.git_status = function() builtin.git_status(themes.get_dropdown({ layout_config = { width = 120 } })) end

-- work-specific actions
M.find_shared_files = find_files({ cwd = '~/code/stitch/src/shared/' })

return M
