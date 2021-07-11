vim.opt_local.spell = true
vim.opt_local.foldlevel = 0

-- prefix the commit message with "feat(<ticket ID>): "
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>t', '5G03w"gyt/gg0ifeat(g): ', { noremap = true, silent = true })
