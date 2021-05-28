let g:coc_global_extensions = [
            \ 'coc-angular',
            \ 'coc-css',
            \ 'coc-cssmodules',
            \ 'coc-emoji',
            \ 'coc-eslint',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-lua',
            \ 'coc-markdownlint',
            \ 'coc-marketplace',
            \ 'coc-pairs',
            \ 'coc-pairs',
            \ 'coc-prettier',
            \ 'coc-pyright',
            \ 'coc-tsserver',
            \ 'coc-yaml'
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
highlight CocErrorSign guifg=#ab4642 guibg=#282828
highlight CocWarningSign guifg=#f7ca88 guibg=#282828
highlight CocInfoSign guifg=#7cafc2 guibg=#282828
highlight CocHintSign guifg=#a0b475 guibg=#282828

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
