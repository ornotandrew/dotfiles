" Neovim compatability {{{

if has('nvim')
    let g:vimprefix = '~/.config/nvim'
else
    let g:vimprefix = '~/.vim'
endif

" }}}
" NeoBundle stuff {{{

set nocompatible
exe 'set runtimepath+=' . g:vimprefix . '/bundle/neobundle.vim/'

call neobundle#begin(expand(g:vimprefix . '/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'suan/vim-instant-markdown'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Valloric/YouCompleteMe', {
\ 'build' : {
\     'mac' : './install.sh --clang-completer',
\     'unix' : './install.sh --clang-completer',
\     'windows' : './install.sh --clang-completer',
\     'cygwin' : './install.sh --clang-completer'
\    }
\ }
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" Color schemes
NeoBundle 'tomasr/molokai'

" Syntax
NeoBundle 'HTML5-Syntax-File'

call neobundle#end()
filetype plugin indent on " Required
NeoBundleCheck            " Check for updates on startup

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
nmap <Leader>u :Unite file file_rec buffer<CR>

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

" }}}
" General {{{

set backspace=indent,eol,start
set undolevels=1000
set spelllang=en_gb
set clipboard=unnamedplus

" }}}
" Indentation {{{

set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set expandtab

" }}}
" UI {{{

colorscheme molokai

set ttyfast
set laststatus=2
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
" Filetype specific {{{

set modelines=1
au BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown wrap spell
au BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell

" }}}
" Backups {{{

" (the directories need to exist)
exe 'set backupdir=' . g:vimprefix . '/backup//'
exe 'set directory=' . g:vimprefix . '/swap//'
exe 'set undodir='   . g:vimprefix . '/undo//'

" }}}
" Custom autocommands {{{

" Reload vimrc on save
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" }}}
" vim:foldmethod=marker:foldlevel=0
