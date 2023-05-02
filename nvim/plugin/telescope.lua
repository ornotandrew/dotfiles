local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    color_devicons = true,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,

    mappings = {
      n = {
        ["<C-q>"] = actions.send_to_qflist,
      },
      i = {
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor()
    }
  }
})
require('telescope').load_extension('fzy_native')
require("telescope").load_extension("ui-select")

local function set_leader_map(key, fn_name)
  vim.api.nvim_set_keymap(
    'n',
    '<leader>' .. key,
    string.format('<cmd>lua require("wraithy.telescope")["%s"]()<CR>', fn_name),
    { noremap = true }
  )
end

set_leader_map('f', 'find_files')
set_leader_map('F', 'find_files_shorten_path')
set_leader_map('d', 'find_config_files')
set_leader_map('R', 'grep_string_fuzzy')
set_leader_map('r', 'grep_string_exact')
set_leader_map('b', 'buffers')
set_leader_map('h', 'help_tags')
set_leader_map('g', 'git_status')

set_leader_map('s', 'find_shared_files')
