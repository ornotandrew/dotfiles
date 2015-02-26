" GVim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Key mappings
let mapleader=","
nnoremap ; :
cmap w!! w !sudo tee > /dev/null %
nnoremap <leader>s :mksession<CR>
nmap <C-t> :NERDTree<CR>
map <Leader><Space> :noh<CR>

" General
set backspace=indent,eol,start
set undolevels=1000

" Colors
syntax on "display syntax
colorscheme molokai
set t_Co=256

" Indentation
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
filetype indent on

" UI
set laststatus=2 "always display the statusline in all windows
set number
set nowrap
set showcmd
set wildmenu
set mouse=a

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Copy/Paste
set pastetoggle=<F2>
set clipboard=unnamedplus

" Plugins
execute pathogen#infect()
autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1

" Use different directories for backup files
" (the directories need to exist)
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Reload .vimrc on save
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

