" Plugins {{{
" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  exec 'silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'chriskempson/base16-vim'

Plug 'Arkham/vim-quickfixdo'
Plug 'bronson/vim-visual-star-search'
Plug 'itchyny/lightline.vim'
Plug 'chrisbra/Colorizer'
Plug 'terryma/vim-expand-region' " TODO: is this useful?
" Plug 'justinmk/vim-sneak'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

Plug 'sjl/gundo.vim'
Plug 'junegunn/goyo.vim'

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" language support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'jparise/vim-graphql'
Plug 'kylef/apiblueprint.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'
Plug 'hashivim/vim-terraform'

call plug#end()

" }}}
" Plugin settings {{{
augroup custom
    autocmd!
augroup END

" base16
let base16colorspace=256
colorscheme base16-default-dark " the theme clears all highlights, so set this here so we can define custom ones
" having a bright red background is really distracting
highlight SpellBad ctermbg=NONE
highlight SpellCap ctermbg=NONE
highlight Error ctermbg=NONE ctermfg=NONE
" use the contextual background instead of always being black
highlight Normal ctermbg=NONE
" make search highlights blend in, while still being visible at a glance
highlight Search ctermfg=1 ctermbg=NONE cterm=bold,underline
highlight! link IncSearch Search

" Coc.nvim
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-tabnine',
    \ 'coc-pairs',
    \ 'coc-marketplace',
    \ 'coc-jedi',
    \ 'coc-eslint',
    \ 'coc-emoji',
    \ 'coc-cssmodules',
    \ 'coc-angular',
    \ 'coc-yaml',
    \ 'coc-pairs',
    \ 'coc-python',
    \ 'coc-pyls',
    \ 'coc-markdownlint',
    \ 'coc-json',
    \ 'coc-css'
    \ ]


" :h coc#on_enter()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" map <tab> to trigger completion and navigate to the next item
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" gutter colors
highlight CocErrorSign ctermfg=1 ctermbg=18 guifg=#ab4642 guibg=#181818
highlight CocWarningSign ctermfg=3 ctermbg=18 guifg=#f7ca88 guibg=#181818
highlight CocInfoSign ctermfg=4 ctermbg=18 gui=bold guifg=#7cafc2 guibg=#181818
highlight CocHintSign ctermfg=2 ctermbg=18 gui=bold guifg=#a0b475 guibg=#181818

nnoremap <silent> <C-]> :call <SID>jump_to_definition()<CR>

function! s:jump_to_definition()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'tag '.expand('<cword>')
  else
    call CocActionAsync('jumpDefinition')
  endif
endfunction

" lightline
let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night',
    \ 'component': {'filename': '%f'},
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ }

" FZF
function! s:fzf_statusline()
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
if executable('rg')
    let $FZF_DEFAULT_COMMAND='rg --files'
endif
autocmd custom FileType fzf tnoremap <nowait><buffer> <esc> <c-g>

let g:fzf_layout = { 'down': '40%' }

" vim-graphql
let g:graphql_javascript_tags = ['gql', 'gqlMoney', 'gqlPushNotifications', 'gqlGlobal']

" vim-terraform
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1


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
nmap <Leader>r :Rg<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>h :History<CR>

nmap <Leader>? <Plug>(coc-references)
nmap <Leader>n <Plug>(coc-rename)
nmap <Leader>a :CocAction<CR>
nmap <leader>q <Plug>(coc-format)
nmap <Leader>m :CocList marketplace<CR>
nnoremap <silent> K :call CocAction('doHover')<CR>
nnoremap <leader>c <Plug>(coc-codeaction)

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
" netrw overwrites <C-l>, and we want to avoid splitting config into vim/after
" as far as possible, so just use an autocmd to steal the mapping back
augroup custom
    autocmd filetype netrw nnoremap <buffer> <C-l> <C-w>l
augroup END

" Read in 12 random hex chars
noremap <silent> <Leader>u "=system('uuidgen \| tr -d " \\t\n-" \| tr "[:upper:]" "[:lower:]"')<CR>p

tmap <Esc> <C-\><C-n>

" }}}
" Settings {{{
let g:python_host_prog='/Users/andrew/venv/neovim2/bin/python'
let g:python3_host_prog='/Users/andrew/venv/neovim/bin/python'

let g:netrw_liststyle=3

set re=0
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
" set undofile
set undolevels=1000
set undoreload=10000
set updatetime=2000 " the default is 4 seconds - I prefer half that

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
    autocmd BufNewFile,BufFilePre,BufRead *.md,*.markdown setlocal filetype=markdown wrap fdm=indent spell
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile*,*.dockerfile setlocal filetype=dockerfile sw=2 ts=2
    autocmd BufNewFile,BufFilePre,BufRead *.tex setlocal wrap spell
    autocmd BufNewFile,BufFilePre,BufRead *.py setlocal fdm=indent sw=4 ts=4
    autocmd BufNewFile,BufFilePre,BufRead *.yml,*.yaml setlocal sw=2 ts=2 fdm=indent
    autocmd BufNewFile,BufFilePre,BufRead *.cpp,*.h setlocal fdm=syntax
    autocmd BufNewFile,BufFilePre,BufRead *.json,*.js,*.ts,*.html,*.scss setlocal sw=2 ts=2 conceallevel=0 fdm=syntax
    autocmd BufNewFile,BufFilePre,BufRead *.ts setlocal filetype=typescript
    autocmd FileType json syntax match Comment +\/\/.\+$+ " enables jsonc syntax
    autocmd BufNewFile,BufFilePre,BufRead .babelrc setlocal ft=json
    autocmd FileType git setlocal fdm=syntax
    autocmd FileType gitcommit setlocal spell
    autocmd FileType go setlocal foldmethod=syntax
    autocmd FileType apiblueprint setlocal spell
    autocmd FileType graphql,typescript,tf setlocal sw=2 ts=2
    " allow h and l to open/close directories so that I don't have to leave the home row
    autocmd FileType netrw nmap <buffer> h <Plug>NetrwLocalBrowseCheck
    autocmd FileType netrw nmap <buffer> l <Plug>NetrwLocalBrowseCheck
    autocmd FileType netrw nmap <buffer> <left> <Plug>NetrwLocalBrowseCheck
    autocmd FileType netrw nmap <buffer> <right> <Plug>NetrwLocalBrowseCheck

    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" }}}
" vim:foldmethod=marker:foldlevel=0
