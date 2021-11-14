-- NOTE: The highlight command is not yet supported. See https://github.com/neovim/neovim/issues/9876

-- having a bright red background is really distracting
vim.api.nvim_command('highlight SpellBad guibg=NONE')
vim.api.nvim_command('highlight SpellCap guibg=NONE')
vim.api.nvim_command('highlight Error guibg=NONE guifg=NONE')

-- use the contextual background instead of always being black
vim.api.nvim_command('highlight Normal guibg=NONE')

-- make search highlights blend in, while still being visible at a glance
vim.api.nvim_command('highlight Search guifg=guifg guibg=guibg gui=bold,underline')
vim.api.nvim_command('highlight! link IncSearch Search')


-- floating windows
vim.api.nvim_command('highlight NormalFloat guibg=none')
vim.api.nvim_command('highlight FloatBorder guifg=#b8b8b8')
