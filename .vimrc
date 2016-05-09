" Plugins {{{

let g:vimdir = '~/.vim'
if has('nvim')
    let g:vimdir = '~/.config/nvim'
endif

" Bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  exec 'silent !curl -fLo ' . g:vimdir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(g:vimdir . '/plugged')

Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
Plug 'benekastah/neomake'
Plug 'chriskempson/base16-vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/a.vim', { 'for': 'cpp' }
Plug 'vim-scripts/utl.vim' | Plug 'tpope/vim-speeddating' | Plug 'jceb/vim-orgmode'
Plug 'mhinz/vim-startify'
Plug 'wraithy/nomanini.vim'

call plug#end()

" }}}
" Plugin settings {{{

" Startify
let g:startify_custom_header = []
let g:startify_bookmarks = [{'v': fnamemodify($MYVIMRC, ':~')}, {'z': '~/.zshrc'}]

" nomanini
let g:nomanini_nose_path = '/home/andrew/code/venv/nomanini/bin/nosetests'
let g:nomanini_gae_path = '/home/andrew/code/google_appengine'

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Universal Text Linking
let g:utl_cfg_hdl_scm_http  = 'silent !google-chrome-stable %u'

" a.vim
let g:alternateSearchPath = 'reg:/src/inc/g/,reg:/inc/src/g/'

" indentLine
let g:indentLine_faster = 1
let g:indentLine_enabled = 0
let g:indentLine_char = '┆'

" lightline
let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night',
    \ 'component': {'filename': '%f'},
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

" vim-markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'json']

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsUsePythonVersion = 2

" Neomake
let g:neomake_remove_invalid_entries = 1
let g:neomake_cpp_gcc_maker = {
    \ 'args': [
    \     '-Wall',
    \     '-Wextra',
    \     '-Werror',
    \     '-Wno-variadic-macros',
    \     '-fexceptions',
    \     '-DNDEBUG',
    \     '-std=c++11',
    \     '-x',
    \     'c++',
    \     '-I',
    \     '/home/andrew/code/nomanini-elula/inc',
    \     '-I',
    \     '/usr/local/include/SDL2',
    \     '-Iinclude'
    \ ]
    \ }

" FZF
function! s:fzf_statusline()
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

if has('nvim')
    autocmd! User FzfStatusLine call <SID>fzf_statusline()
    let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

if executable('ag')
    let $FZF_DEFAULT_COMMAND='ag --ignore=*.pyc -g ""'
endif

" }}}
" Key mappings {{{

let mapleader=" "
let localleader="\\"
cmap w!! w !sudo tee > /dev/null %
nmap <F5> :tp<CR>
nmap <F6> :tn<CR>
nmap <Leader><Space> :noh<CR>
nmap <Leader>l :setlocal list!<CR>
nmap <Leader>s :setlocal spell!<CR>
nmap <Leader>v :tabe $MYVIMRC<CR>
nmap <Leader>w :setlocal wrap!<CR>
nmap <Leader>z :setlocal foldenable!<CR>
nmap <Leader>j :'<,'>!python -m json.tool<CR>
nnoremap Y y$

" Plugins
nmap <Leader>a :Ag<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>i :IndentLinesToggle<CR>
nmap <F4> :Ttoggle<CR>

" Visual movement
imap <Down> <Esc>gja
imap <Up> <Esc>gka
nmap <Down> g<Down>
nmap <Up> g<UP>
nmap j gj
nmap k gk

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Switching tabs
noremap <M-j> gT
noremap <M-k> gt
noremap <M-l> gt
noremap <M-h> gT

" Convert double-quote strings to unicode
nmap <Leader>u :'<,'>s/\v"([^"]*)"/u''\1''/g<CR>

if has('nvim')
    tmap <Esc> <C-\><C-n>
endif

" }}}
" General {{{

filetype plugin indent on
set nocompatible
set backspace=indent,eol,start
set undofile
set undolevels=1000
set undoreload=10000
set spelllang=en_gb
set clipboard=unnamedplus
set wildignore=*.o,*.pyc

" Indent
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set expandtab

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" }}}
" UI {{{

colorscheme base16-default
set background=dark
let base16colorspace=256

syntax on

set cursorline
set hidden
set linebreak
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
set mouse=a
set noshowmode " use lightline instead
set nowrap
set number
set scrolloff=3
set showcmd
set t_Co=256 " Neovim ignores this
set title
set ttyfast
set wildmenu
set wildmode=longest,full

" Cursor
if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    au! InsertEnter * :redraw!
    au! InsertLeave * :redraw!
endif

" }}}
" Filetype specific {{{

augroup filetypes
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown wrap spell
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile* setlocal filetype=dockerfile sw=2 ts=2
    autocmd BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell
    autocmd BufNewFile,BufFilePre,BufRead *.py setlocal sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.yml,*.yaml setlocal sw=2 ts=2
    autocmd BufNewFile,BufFilePre,BufRead *.org setlocal sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.cpp,*.h setlocal foldmethod=syntax
augroup END

" }}}
" Autocommands and functions {{{
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup custom
    autocmd!
    autocmd FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
    autocmd BufRead,BufWritePost * silent Neomake
    autocmd BufEnter * let &titlestring = hostname() . " - vim - [ " . expand("%:t") . " ]"
augroup END

" }}}
" Backups {{{

call system('mkdir -p' . g:vimdir . '/swap//')
call system('mkdir -p' . g:vimdir . '/undo//')
execute 'set directory=' . g:vimdir . '/swap//'
execute 'set undodir=' . g:vimdir .'/undo//'

" }}}
" vim:foldmethod=marker:foldlevel=0
