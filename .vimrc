" Colors
syntax on
colorscheme molokai
set t_Co=256

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
filetype plugin indent on

" UI
set number
set wildmenu

" Search
set incsearch
set hlsearch

" Plugins
execute pathogen#infect()
autocmd VimEnter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " This will close vim if the only window left is NERDTree
