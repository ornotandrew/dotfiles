" Neovim compatability {{{

let g:vimdir = '~/.vim'
if has('nvim')
    let g:vimdir = '~/.config/nvim'
endif

" }}}
" NeoBundle {{{

filetype off

" Install NeoBundle if it doesn't exist
if !filereadable(expand(g:vimdir . '/bundle/neobundle.vim/README.md'))
  echo "Installing NeoBundle..."
  echo ""
  execute 'silent !mkdir -p ' . g:vimdir . '/bundle'
  execute 'silent !git clone https://github.com/Shougo/neobundle.vim ' . g:vimdir . '/bundle/neobundle.vim/'
endif

set nocompatible
execute 'set runtimepath+=' . g:vimdir . '/bundle/neobundle.vim/'

call neobundle#begin(expand(g:vimdir . '/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'mkitt/tabline.vim'
" NeoBundle 'Shougo/unite.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'benekastah/neomake'
NeoBundle 'honza/vim-snippets'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'suan/vim-instant-markdown'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'
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
NeoBundle 'nanotech/jellybeans.vim'

" Syntax
NeoBundle 'HTML5-Syntax-File'

call neobundle#end()
filetype plugin indent on " Required
NeoBundleCheck            " Check for updates on startup

" }}}
" Plugin settings {{{

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsUsePythonVersion = 2

" YCM Completing
let g:ycm_key_list_select_completion = ['<tab>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<s-tab>', '<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = g:vimdir . '/ycm_default_flags.py'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0 " Let Neomake do the linting

" Neomake
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
    \     '-I/usr/local/include/SDL2',
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
    let $FZF_DEFAULT_COMMAND='ag -g ""'
endif

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
nnoremap Y y$

if has("nvim")
	tnoremap <C-\> <C-\><C-n>
endi

" FZF
nmap <Leader>b :Buffers<CR>
nmap <Leader>a :Ag<CR>
nmap <Leader>f :Files<CR>

" Visual movement
set scrolloff=3
nmap <Up> g<UP>
nmap <Down> g<Down>
imap <Up> <Esc>gka
imap <Down> <Esc>gja
nmap j gj
nmap k gk

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

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

syntax on
set t_Co=256
set ttyfast
set mouse=a
set number
set nowrap
set linebreak
set showcmd
set title
set wildmenu
set wildmode=longest,full
set wildignore=*.o
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
set cursorline

" Statusline
set laststatus=2
set statusline=%f        " file path
set statusline+=\ %m     " modified flag
set statusline+=%r       " read-only flag
set statusline+=%y       " filetype
set statusline+=%=       " switch to right side
set statusline+=\ %l/%L  " lines in file
set statusline+=\        " space before end

" }}}
" Search {{{

set incsearch
set hlsearch
set ignorecase
set smartcase

" }}}
" Filetype specific {{{

set modelines=1
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown wrap spell
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile.* setlocal filetype=dockerfile
    autocmd BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell
    autocmd BufNewFile,BufFilePre,BufRead *.py setlocal sw=4 ts=4
augroup END

" }}}
" Autocommands {{{

augroup custom
    autocmd!
    autocmd BufRead,BufWritePost * Neomake
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd BufEnter * let &titlestring = hostname() . " - vim - [ " . expand("%:t") . " ]"
augroup END

" }}}
" Backups {{{

" (the directories need to exist)
execute 'set backupdir=' . g:vimdir . '/backup//'
execute 'set directory=' . g:vimdir . '/swap//'
execute 'set undodir='   . g:vimdir . '/undo//'

" }}}
" vim:foldmethod=marker:foldlevel=0
