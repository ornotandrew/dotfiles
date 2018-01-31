" Plugins {{{
" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  exec 'silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'bronson/vim-visual-star-search'
Plug 'chriskempson/base16-vim'
" Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'hail2u/vim-css3-syntax'
Plug 'honza/vim-snippets'
Plug 'hynek/vim-python-pep8-indent'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kylef/apiblueprint.vim'
Plug 'majutsushi/tagbar'
Plug 'nelstrom/vim-markdown-folding'
Plug 'othree/html5-syntax.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'roxma/nvim-completion-manager'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

" }}}
" Plugin settings {{{
augroup custom
    autocmd!
augroup END

" base16
let base16colorspace=256
colorscheme base16-default-dark " the theme clears all highlights, so set this here so we can define custom ones

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

" ALE
let g:ale_sign_error = '🗙'
let g:ale_sign_warning = '!'
let g:ale_sign_info = 'i'

highlight ALEErrorSign ctermfg=1 ctermbg=18 guifg=#ab4642 guibg=#181818 
highlight ALEInfoSign ctermfg=4 ctermbg=18 gui=bold guifg=#7cafc2 guibg=#181818 
highlight ALEWarningSign ctermfg=3 ctermbg=18 guifg=#f7ca88 guibg=#181818 

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1

" Goyo
autocmd User GoyoEnter nested set nocursorline wrap

" Neosnippet
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1

" jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" vim-go
let g:go_fmt_fail_silently = 1
let g:go_template_autocreate = 0
let g:go_fmt_command = "goimports"

" vim-gitgutter
let g:gitgutter_sign_added = '·'
let g:gitgutter_sign_modified = '·'
let g:gitgutter_sign_removed = '·'
let g:gitgutter_sign_modified_removed = '·'

" language server
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" nvim-completion-manager
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


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
nmap <Leader>t :TagbarToggle<CR>

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

" Store an iso8601 date for use in examples
let @d = '2017-01-01T12:00:00+00:00'

" Read in 12 random hex chars
noremap <silent> <F9> "=system('uuidgen \| tr -d " \\t\n"')<CR>p

if has('nvim')
    tmap <Esc> <C-\><C-n>
endif

" }}}
" Settings {{{
set backupcopy=yes
set clipboard=unnamedplus
set completeopt-=preview
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
    autocmd BufNewFile,BufFilePre,BufRead *.md,*.markdown setlocal filetype=markdown wrap spell fdm=indent
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile* setlocal filetype=dockerfile sw=2 ts=2
    autocmd BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell
    autocmd BufNewFile,BufFilePre,BufRead *.py setlocal fdm=indent sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.yml,*.yaml setlocal sw=2 ts=2 fdm=indent
    autocmd BufNewFile,BufFilePre,BufRead *.org setlocal sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.cpp,*.h setlocal fdm=syntax
    autocmd BufNewFile,BufFilePre,BufRead *.json,*.js,*.html setlocal sw=2 ts=2 conceallevel=0
    autocmd FileType gitcommit setlocal spell tw=75
    autocmd FileType go setlocal foldmethod=syntax
    autocmd FileType apiblueprint setlocal spell

    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" }}}
" vim:foldmethod=marker:foldlevel=0
