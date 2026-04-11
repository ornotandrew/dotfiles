-- General
vim.keymap.set('n', '<Leader><Space>', ':noh<CR>', { silent = true })
vim.keymap.set('n', '<Leader>l', ':setlocal list!<CR>', { silent = true })
vim.keymap.set('n', '<Leader>q', ':cwindow<CR>')
vim.keymap.set('n', '<Leader>w', ':setlocal wrap!<CR>')
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

-- VSCode related things
local actionfn = function(action_name)
  return function()
    require('vscode').action(action_name)
  end
end
vim.keymap.set('n', '<leader>f', actionfn('workbench.action.quickOpen'))
vim.keymap.set('n', '<leader>r', actionfn('workbench.action.findInFiles'))
vim.keymap.set('n', '<C-]>', actionfn('editor.action.goToDeclaration'))
vim.keymap.set('n', 'g?', actionfn('editor.action.referenceSearch.trigger'))
vim.keymap.set('n', '<leader>?', actionfn('references-view.findReferences'))
vim.keymap.set('n', ']d', actionfn('editor.action.marker.next'))
vim.keymap.set('n', '[d', actionfn('editor.action.marker.prev'))
vim.keymap.set('n', '<leader>a', actionfn('editor.action.quickFix'))
vim.keymap.set('n', '<leader>n', actionfn('editor.action.rename'))
vim.keymap.set('n', '<Leader>w', actionfn('editor.action.toggleWordWrap'))
vim.keymap.set('n', '<Leader>p', actionfn('workbench.actions.view.problems'))

-- Folds
vim.keymap.set('n', 'za', actionfn('editor.toggleFold'))
vim.keymap.set('n', 'zR', actionfn('editor.unfoldAll'))
vim.keymap.set('n', 'zM', actionfn('editor.foldAll'))
vim.keymap.set('n', 'zo', actionfn('editor.unfold'))
vim.keymap.set('n', 'zO', actionfn('editor.unfoldRecursively'))
vim.keymap.set('n', 'zc', actionfn('editor.fold'))
vim.keymap.set('n', 'zC', actionfn('editor.foldRecursively'))
vim.keymap.set('n', 'z1', actionfn('editor.foldLevel1'))
vim.keymap.set('n', 'z2', actionfn('editor.foldLevel2'))
vim.keymap.set('n', 'z3', actionfn('editor.foldLevel3'))
vim.keymap.set('n', 'z4', actionfn('editor.foldLevel4'))
vim.keymap.set('n', 'z5', actionfn('editor.foldLevel5'))
vim.keymap.set('n', 'z6', actionfn('editor.foldLevel6'))
vim.keymap.set('n', 'z7', actionfn('editor.foldLevel7'))
vim.keymap.set('n', 'zV', actionfn('editor.foldAllExcept'))

-- https://github.com/vscode-neovim/vscode-neovim/issues/1627
vim.keymap.set('n', 'gq', 'gw', { remap = false })
vim.keymap.set('n', 'gqq', 'gww', { remap = false })
