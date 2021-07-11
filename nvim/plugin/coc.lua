local t = require('wraithy/util').t

vim.g.coc_global_extensions = {
  'coc-angular',
  'coc-css',
  'coc-cssmodules',
  'coc-emoji',
  'coc-eslint',
  'coc-html',
  'coc-json',
  'coc-lua',
  'coc-markdownlint',
  'coc-marketplace',
  'coc-pairs',
  'coc-pairs',
  'coc-prettier',
  'coc-pyright',
  'coc-tsserver',
  'coc-yaml'
}

local silent_expr = {silent = true, expr = true}

-- :h coc#on_enter()
function _G.smart_enter()
  return vim.fn.pumvisible() == 1 and vim.fn['coc#_select_confirm']() or t('<C-g>u<CR><c-r>=coc#on_enter()<CR>')
end

vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.smart_enter()', {silent=true, expr=true, noremap=true})
vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', silent_expr)

-- map <tab> to trigger completion and navigate to the next item
function check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or (check_back_space() and t'<Tab>' or vim.fn['coc#refresh']())
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<C-h>"', silent_expr)


-- gutter colors
-- NOTE: The highlight command is not yet supported. See https://github.com/neovim/neovim/issues/9876
vim.api.nvim_command('highlight CocErrorSign guifg=#ab4642 guibg=#282828')
vim.api.nvim_command('highlight CocWarningSign guifg=#f7ca88 guibg=#282828')
vim.api.nvim_command('highlight CocInfoSign guifg=#7cafc2 guibg=#282828')
vim.api.nvim_command('highlight CocHintSign guifg=#a0b475 guibg=#282828')

-- jump to definition
function _G.jump_to_definition()
    local excluded_filetypes = {vim = true, help = true}
    if excluded_filetypes[vim.bo.filetype] then
        vim.api.nvim_command('execute "tag ".expand("<cword>")')
    else
        vim.api.nvim_command('call CocActionAsync("jumpDefinition")')
    end
end

vim.api.nvim_set_keymap('n', '<C-]>', ':call v:lua.jump_to_definition()<CR>', {silent = true})

-- key mappings
vim.api.nvim_set_keymap('n', '<leader>?', '<Plug>(coc-references)', {})
vim.api.nvim_set_keymap('n', '<leader>n', '<Plug>(coc-rename)', {})
vim.api.nvim_set_keymap('n', '<leader>a', ':CocAction<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>q', '<Plug>(coc-format)', {})
vim.api.nvim_set_keymap('n', '<leader>m', ':CocList marketplace<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>K', ':call CocAction("doHover")<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>c', '<Plug>(coc-codeaction)', {})
