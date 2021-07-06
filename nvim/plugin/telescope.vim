lua << EOF
local actions = require('telescope.actions')
require'telescope'.setup {
  defaults = {
    color_devicons = true,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    
    mappings = {
      n = {
        ["<C-q>"] = actions.send_to_qflist,
      },
      i = {
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
  }
}
require('telescope').load_extension('fzy_native')
EOF

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer=false, width=120 }))<cr>
nnoremap <leader>F <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ shorten_path=true, previewer=false, width=120 }))<cr>
nnoremap <leader>d <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer=false, width=120, cwd='~/.config/nvim/' }))<cr>
nnoremap <leader>r <cmd>lua require('telescope.builtin').grep_string({ search = '' })<cr>
nnoremap <leader>R <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown({ width=120 }))<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
