" Plugins {{{
" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  exec 'silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'Arkham/vim-quickfixdo'
Plug 'bronson/vim-visual-star-search'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'janko-m/vim-test'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

Plug 'sjl/gundo.vim'

" language support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'jparise/vim-graphql'
Plug 'kylef/apiblueprint.vim'
Plug 'mxw/vim-jsx'
Plug 'othree/html5-syntax.vim'
" Plug 'pangloss/vim-javascript'

call plug#end()

" }}}
" Plugin settings {{{
augroup custom
    autocmd!
augroup END

" base16
let base16colorspace=256
colorscheme base16-default-dark " the theme clears all highlights, so set this here so we can define custom ones
" these highlight groups are used by ALE, and having a background is really distracting
hi SpellBad ctermbg=NONE
hi SpellCap ctermbg=NONE

" lightline
let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night',
    \ 'component': {'filename': '%f'},
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

" FZF
function! s:fzf_statusline()
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
let $FZF_DEFAULT_OPTS .= ' --inline-info'
if executable('ag')
    let $FZF_DEFAULT_COMMAND='ag -g ""'
endif
autocmd custom FileType fzf tnoremap <nowait><buffer> <esc> <c-g>

" vim-test
let test#strategy = "neovim"
let test#javascript#jest#options = '--detectOpenHandles --forceExit'

" }}}
" Key mappings {{{

let mapleader = "\<space>" 
let localleader="\\"
cmap w!! w !sudo tee > /dev/null %
nmap <Leader><Space> :noh<CR>
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
nmap <Leader>h :History<CR>
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>T :TestFile<CR>

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

" Convert camelCase to camel_case
let @u = 's#\(\<\u\l\+\|\l\+\)\(\u\)#\l\1_\l\2#g'
let @c = 's#_\(\l\)#\u\1#g'

" Move params onto newlines
let @p = 'vi):s/,\ /,\r/gvi)=f(%i:nohl'

" Store an iso8601 date for use in examples
let @d = '2017-01-01T12:00:00+00:00'

" Read in 12 random hex chars
noremap <silent> <Leader>u "=system('uuidgen \| tr -d " \\t\n-" \| tr "[:upper:]" "[:lower:]"')<CR>p

" Split a JSON object onto individual lines
let @j ='vi{:s/,\zs\ /\r/gf}hrl%lrvi{=:noh'

tmap <Esc> <C-\><C-n>

" }}}
" Settings {{{
let g:python_host_prog='/Users/andrew/venv/neovim2/bin/python'
let g:python3_host_prog='/Users/andrew/venv/neovim/bin/python'

set backupcopy=yes
set clipboard=unnamedplus
set cursorline
set expandtab
set foldmethod=indent
set hidden
set hlsearch
set ignorecase
set inccommand=split
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

set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=.hg/
set wildignore+=__pycache__/

call system('mkdir -p ~/.config/nvim/swap//')
call system('mkdir -p ~/.config/nvim/undo//')
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

let $PAGER = ''

" }}}
" Autocommands {{{

augroup custom
    autocmd BufNewFile,BufFilePre,BufRead *.md,*.markdown setlocal filetype=markdown wrap fdm=indent
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile* setlocal filetype=dockerfile sw=2 ts=2
    autocmd BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell
    autocmd BufNewFile,BufFilePre,BufRead *.py setlocal fdm=indent sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.yml,*.yaml setlocal sw=2 ts=2 fdm=indent
    autocmd BufNewFile,BufFilePre,BufRead *.cpp,*.h setlocal fdm=syntax
    autocmd BufNewFile,BufFilePre,BufRead *.json,*.js,*.html setlocal sw=2 ts=2 conceallevel=0 fdm=syntax
    autocmd BufNewFile,BufFilePre,BufRead .babelrc setlocal ft=json
    autocmd FileType gitcommit setlocal spell tw=75
    autocmd FileType go setlocal foldmethod=syntax
    autocmd FileType apiblueprint setlocal spell
    autocmd FileType graphql,typescript setlocal sw=2 ts=2

    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" }}}
" vim:foldmethod=marker:foldlevel=0
