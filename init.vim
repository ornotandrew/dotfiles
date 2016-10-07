" Plugins {{{
" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  exec 'silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
Plug 'benekastah/neomake'
Plug 'bronson/vim-visual-star-search'
Plug 'chriskempson/base16-vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'hynek/vim-python-pep8-indent'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kylef/apiblueprint.vim'
Plug 'metakirby5/codi.vim'
Plug 'nelstrom/vim-markdown-folding'
Plug 'othree/html5-syntax.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'zchee/deoplete-jedi'
call plug#end()

" }}}
" Plugin settings {{{
augroup custom
    autocmd!
augroup END

" base16
let base16colorspace=256

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" deoplete
let g:deoplete#enable_at_startup = 1

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

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsUsePythonVersion = 2

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
    let $FZF_DEFAULT_COMMAND='ag -g ""'
endif
autocmd custom FileType fzf tnoremap <nowait><buffer> <esc> <c-g>

" Neomake
let g:neomake_cpp_enabled_makers = []
let g:neomake_apiblueprint_drafter_maker = {
    \ 'exe': 'drafter',
    \ 'args': ['-l', '-u'],
    \ 'mapexpr': 'expand("%:p") . ": " . v:val',
    \ 'errorformat': '%f: %t%[%^:]\\+: (%n) %m; line %l\, column %c%.%#'
    \ }
let g:neomake_apiblueprint_enabled_makers = ['drafter']
autocmd custom BufRead,BufWritePost * silent Neomake | call neomake#signs#DefineHighlights()

" Goyo
autocmd User GoyoEnter nested set nocursorline wrap

" }}}
" Key mappings {{{

let mapleader=" "
let localleader="\\"
cmap w!! w !sudo tee > /dev/null %
nmap <F5> :tp<CR>
nmap <F6> :tn<CR>
nmap <Leader><Space> :noh<CR>
nmap <Leader>j :'<,'>!python -m json.tool<CR>
nmap <Leader>l :setlocal list!<CR>
nmap <Leader>q :cwindow<CR>
nmap <Leader>s :setlocal spell!<CR>
nmap <Leader>v :tabe $MYVIMRC<CR>
nmap <Leader>w :setlocal wrap!<CR>
nmap <Leader>z :setlocal foldenable!<CR>
nnoremap Y y$

" Plugins
nmap <Leader>a :Ag<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>g :Goyo<CR>
nmap <Leader>h :History<CR>
nmap <Leader>i :IndentLinesToggle<CR>
nmap <Leader>t :TestSingle<CR>

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

" Convert double-quote strings to unicode
let @u = 's/\v"([^"]*)"/u''\1''/g'

" Read in 12 random hex chars
noremap <silent> <F9> "=system('dd if=/dev/random bs=6 count=1 2>/dev/null \| od -An -tx1 \| tr -d " \\t\n"')<CR>p

if has('nvim')
    tmap <Esc> <C-\><C-n>
endif

" }}}
" Settings {{{

colorscheme base16-default-dark

set clipboard=unnamedplus
set completeopt-=preview
set cursorline
set expandtab
set hidden
set hlsearch
set ignorecase
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
set mouse=a
set noshowmode " use lightline instead
set nowrap
set number
set relativenumber
set shiftwidth=4
set showbreak=↪
set smartcase
set spelllang=en_gb
set tabstop=4
set undofile
set undolevels=1000
set undoreload=10000

set wildignore+=*.min.js
set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=.hg/
set wildignore+=__pycache__/

call system('mkdir -p ~/.config/nvim/swap//')
call system('mkdir -p ~/.config/nvim/undo//')
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $PAGER = ''

" }}}
" Autocommands {{{

augroup custom
    autocmd BufNewFile,BufFilePre,BufRead *.md,*.markdown setlocal filetype=markdown wrap spell fdm=indent
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile* setlocal filetype=dockerfile sw=2 ts=2
    autocmd BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell
    autocmd BufNewFile,BufFilePre,BufRead *.py setlocal fdm=indent sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.yml,*.yaml setlocal sw=2 ts=2 fdm=indent
    autocmd BufNewFile,BufFilePre,BufRead *.org setlocal sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.cpp,*.h setlocal fdm=syntax
    autocmd BufNewFile,BufFilePre,BufRead *.json setlocal sw=2 ts=2
    autocmd FileType gitcommit setlocal spell tw=75

    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" }}}
" vim:foldmethod=marker:foldlevel=0
