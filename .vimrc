" Vundle stuff {{{
set nocompatible			  " be iMproved, required
filetype off				  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

" Color schemes
Plugin 'tomasr/molokai'
Plugin 'sjl/badwolf'

" Syntax
Plugin 'HTML5-Syntax-File'

" All of your Plugins must be added before the following line
call vundle#end()			 " required
filetype plugin indent on	 " required
" }}}
" Plugin settings {{{
" make YCM compatible with UltiSnips
let g:ycm_key_list_select_completion = ['<tab>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<s-tab>', '<C-p>', '<Up>']

let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" YCM
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" NERDCommenter
let NERDSpaceDelims=1
" }}}
" Key mappings {{{
let mapleader=","
nnoremap ; :
cmap w!! w !sudo tee > /dev/null %
nmap <Leader>v :tabe $MYVIMRC<CR>
nmap <Leader><Space> :noh<CR>
nmap <Leader>s :setlocal spell!<CR>
nmap <Leader>l :setlocal list!<CR>
nmap <Leader>w :setlocal wrap!<CR>
nmap <Leader>m :SyntasticToggleMode<CR>
nnoremap Y y$

if has("nvim")
	tnoremap <C-\> <C-\><C-n>
endi

" Visual movement
set scrolloff=3
nmap <Up> g<UP>
nmap <Down> g<Down>
imap <Up> <Esc>gka
imap <Down> <Esc>gja
nmap j gj
nmap k gk

" Tabs
map <C-PageUp> :tabp<CR>
map <C-PageDown> :tabn<CR>
" }}}
" General {{{
set backspace=indent,eol,start
set undolevels=1000
set spelllang=en_gb
" set lazyredraw
set ttyfast
" }}}
" Colors {{{
syntax on
if !has("gui_running")
	if $TERM == "xterm"
		let $TERM = "xterm-256color"
	endif
	set t_Co=256
endif
colorscheme molokai
" }}}
" Indentation {{{
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set expandtab
" }}}
" UI {{{
set ttyfast
set laststatus=2 "always display the statusline in all windows
set mouse=n
set number
set nowrap
set linebreak
set showcmd
set wildmenu
set wildmode=longest,full
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
set cursorline
" }}}
" Search {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
" }}}
" Copy/Paste {{{
set clipboard=unnamedplus
" }}}
" Filetype specific {{{
set modelines=1
au BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown wrap spell
au BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell
" }}}
" Backups {{{
" (the directories need to exist)
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
" }}}
" Custom autocommands {{{
if has("autocmd")
	" Reload vimrc on save
	augroup reload_vimrc
		autocmd!
		autocmd BufWritePost $MYVIMRC source $MYVIMRC
	augroup END
endif
" }}}
" vim:foldmethod=marker:foldlevel=0
