set termguicolors

set clipboard=unnamedplus

set cursorline
set noshowmode " use lightline instead
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
set mouse=a

set backupcopy=yes
set expandtab

set hidden

set hlsearch

set inccommand=split

set number
set relativenumber

set shiftwidth=4
set tabstop=4

set nowrap
set showbreak=↪
set ignorecase
set smartcase
set spelllang=en_gb
set scrolloff=8

set foldmethod=syntax

set undofile
set undolevels=1000
set undoreload=10000
set updatetime=2000 " the default is 4 seconds - I prefer half that

set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=.hg/
set wildignore+=__pycache__/

call system('mkdir -p ~/.config/nvim/swap//')
call system('mkdir -p ~/.config/nvim/undo//')
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

let $PAGER = ''

let g:python_host_prog='/Users/andrew/venv/neovim2/bin/python'
let g:python3_host_prog='/Users/andrew/venv/neovim/bin/python'
