-- General
vim.keymap.set('n', '<Leader><Space>', ':noh<CR>', { silent = true })
vim.keymap.set('n', '<Leader>l', ':setlocal list!<CR>', { silent = true })
vim.keymap.set('n', '<Leader>q', ':cwindow<CR>')
vim.keymap.set('n', '<Leader>w', ':setlocal wrap!<CR>')
-- vim.keymap.set('n', '<Leader>c', ':CodeCompanionActions<CR>')
-- vim.keymap.set('v', '<Leader>c', ':CodeCompanionActions<CR>')
vim.keymap.set('v', '<Leader>k', ':CodeCompanion<CR>')
vim.keymap.set('n', 'gx', ":execute 'silent! !open ' . shellescape(expand('<cWORD>'), 1)<cr>", { silent = true })
vim.keymap.set('n', 'Y', 'y$', { remap = false })

-- Visual movement
vim.keymap.set('i', '<Down>', '<Esc>gja')
vim.keymap.set('i', '<Up>', '<Esc>gka')
vim.keymap.set('n', '<Down>', 'g<Down>')
vim.keymap.set('n', '<Up>', 'g<Up>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Switching windows
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<C-' .. key .. '>', '<C-w>' .. key)
end
