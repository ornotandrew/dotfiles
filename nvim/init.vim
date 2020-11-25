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

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" buffer/file management
Plug 'tpope/vim-vinegar'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

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

augroup custom
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

let mapleader = "\<space>" 
let localleader="\\"

" chriskempson/base16-vim {{{
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
" }}}
" neoclide/coc.nvim {{{
let g:coc_global_extensions = [
            \ 'coc-tsserver',
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
            \ 'coc-markdownlint',
            \ 'coc-json',
            \ 'coc-css'
            \ ]


" :h coc#on_enter()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <c-space> coc#refresh()

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

nmap <Leader>? <Plug>(coc-references)
nmap <Leader>n <Plug>(coc-rename)
nmap <Leader>a :CocAction<CR>
nmap <leader>q <Plug>(coc-format)
nmap <Leader>m :CocList marketplace<CR>
nnoremap <silent> K :call CocAction('doHover')<CR>
nnoremap <leader>c <Plug>(coc-codeaction)
" }}}
" itchyny/lightline.vim {{{
let g:lightline = {
            \ 'colorscheme': 'Tomorrow_Night',
            \ 'component': {'filename': '%f'},
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ }
" }}}
" junegunn/fzf {{{
if executable('rg')
    let $FZF_DEFAULT_COMMAND='rg --files'
endif
autocmd custom FileType fzf tnoremap <nowait><buffer> <esc> <c-g>

let g:fzf_layout = { 'down': '40%' }

nmap <Leader>r :Rg<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>h :History<CR>
" }}}
" hashivim/vim-terraform {{{
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1
" }}}
" preservim/nerdtree {{{
function! s:attempt_select_last_file()
    let l:previous=expand('#:t')
    if l:previous != ''
        call search('\v<' . l:previous . '>')
    endif
endfunction

augroup custom
    autocmd User NERDTreeInit call s:attempt_select_last_file()
augroup END

let g:NERDTreeMinimalUI=1
let g:NERDTreeMapUpdir="-"
let g:NERDTreeMapActivateNode="l"
let g:NERDTreeMapCloseDir="h"
let g:NERDTreeIgnore=["*.pyc", "__pycache__"]
" }}}

" vim:foldmethod=marker:foldlevel=0
