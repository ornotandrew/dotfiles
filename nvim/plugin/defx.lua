-- emulate vim-vinegar
vim.api.nvim_set_keymap('n', '-', "<cmd>Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`<CR>", { silent = true })

vim.fn['defx#custom#option']('_', { columns = 'mark:indent:icons:space:filename:size' })

function _G.defx_buf_settings()
  local map_key = function (key, action)
    vim.api.nvim_buf_set_keymap(0, 'n', key, action, { silent = true, expr = true, noremap = true })
  end

  map_key('<CR>', "defx#do_action('open')")
  map_key('c', "defx#do_action('copy')")
  map_key('m', "defx#do_action('move')")
  map_key('p', "defx#do_action('paste')")
  map_key('l', "defx#do_action('open')")
  map_key('o', "defx#do_action('open_tree', 'toggle')")
  map_key('O', "defx#do_action('open_tree', 'recursive')")
  map_key('%', "defx#do_action('new_file')")
  map_key('d', "defx#do_action('remove')")
  map_key('r', "defx#do_action('rename')")
  map_key('yy', "defx#do_action('yank_path')")
  map_key('.', "defx#do_action('toggle_ignored_files')")
  map_key('-', "defx#do_action('cd', ['..'])")
  map_key('h', "defx#do_action('cd', ['..'])")
  map_key('<tab>', "defx#do_action('toggle_select')")
  map_key('*', "defx#do_action('toggle_select_all')")
  map_key('cd', "defx#do_action('change_vim_cwd')")
end

vim.api.nvim_command('autocmd FileType defx call v:lua.defx_buf_settings()')
