-- General
vim.o.clipboard = 'unnamedplus'
vim.o.inccommand = 'split' -- show the effects of a substitute command in a separate window
vim.o.spelllang = 'en_gb'
vim.o.spell = false
vim.o.formatprg = 'par -w80'
vim.o.foldmethod = 'syntax'

-- Editor look & feel
vim.o.cursorline = true
vim.o.listchars = 'eol:¬,tab:¦ ,trail:~,extends:>,precedes:<'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.showbreak = '↪'
vim.o.showtabline = 1

-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Tabs/spaces
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- History and backup
vim.o.backupcopy = 'yes'
vim.o.undofile = true
vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.updatetime = 500 -- the default is 4 seconds

-- Ensure these dirs exist before trying to use them
-- vim.o.directory = util.ensure_directory_exists('~/.config/nvim/swap//')
-- vim.o.undodir = util.ensure_directory_exists('~/.config/nvim/undo//')
