" Key mappings
let mapleader=","
nnoremap ; :
cmap w!! w !sudo tee > /dev/null %
nmap <C-t> :NERDTree<CR>
map <Leader><Space> :noh<CR>
nnoremap <F3> :set list!<CR>
nmap <Leader>s :NERDTreeClose<CR> :mksession!<CR> :NERDTree<CR>
nmap <Leader>o :source Session.vim<CR> :NERDTree<CR>

" General
set backspace=indent,eol,start
set undolevels=1000
filetype plugin on

" Colors
syntax on
colorscheme molokai
if !has('gui_running')
  set t_Co=256
endif

" Indentation
filetype indent on
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set noexpandtab

" UI
set laststatus=2 "always display the statusline in all windows
set number
set nowrap
set showcmd
set wildmenu
set mouse=a
set listchars=eol:¬,tab:▸\ ,trail:~,extends:>,precedes:<
set cursorline

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Copy/Paste
"set pastetoggle=<F2>
set clipboard=unnamedplus

" Plugins
execute pathogen#infect()
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

