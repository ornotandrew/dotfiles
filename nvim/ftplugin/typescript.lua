require('wraithy.util').set_spaces_per_tab(2)
vim.opt_local.foldmethod = 'indent'
vim.opt_local.conceallevel = 0
vim.opt_local.errorformat = '%f\\(%l\\,%c\\): error %m'
vim.opt_local.makeprg = 'pnpm tsc --noEmit --pretty false'
