-- emulate vim-vinegar
vim.api.nvim_set_keymap('n', '-', "<cmd>Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')` -show-ignored-files -new<CR>", { silent = true })

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
  map_key('r', "defx#do_action('rename')")
  map_key('d', "defx#do_action('remove')")
  map_key('yy', "defx#do_action('yank_path')")
  map_key('.', "defx#do_action('toggle_ignored_files')")
  map_key('-', "defx#do_action('cd', ['..'])")
  map_key('h', "defx#do_action('cd', ['..'])")
  map_key('<tab>', "defx#do_action('toggle_select')")
  map_key('*', "defx#do_action('toggle_select_all')")
  map_key('cd', "defx#do_action('change_vim_cwd')")

  -- TODO: get bulk-delete working
end


-- override netrw when opening directories via :e, :vsp etc
function _G.defx_hijack()
    local path = vim.fn.expand("<amatch>")

    if vim.fn.isdirectory(path) == 0 then return end
    if path == "" then return end
    if string.format("%d", vim.fn.bufnr("%")) ~= vim.fn.expand("<abuf>") then return end
    if vim.bo.filetype == "defx" then return end

    vim.api.nvim_command("Defx -new `expand('%:p:h')`")
end

vim.api.nvim_exec([[
augroup defx_config
  autocmd!
  autocmd FileType defx call v:lua.defx_buf_settings()
  autocmd BufEnter * call v:lua.defx_hijack()
augroup END
]], false)
