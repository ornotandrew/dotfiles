require('wraithy/util').set_spaces_per_tab(2)
vim.opt_local.conceallevel = 0
vim.opt_local.foldmethod = 'indent' -- TODO - why doesn't `syntax` work?

-- The syntax command is not yet supported. See https://github.com/neovim/neovim/issues/9876
vim.api.nvim_eval('syntax match Comment +\/\/.\+$+') -- enables jsonc syntax
