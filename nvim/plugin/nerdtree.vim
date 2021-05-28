function! s:attempt_select_last_file()
    let l:previous=expand('#:t')
    if l:previous != ''
        call search('\v<' . l:previous . '>')
    endif
endfunction

autocmd User NERDTreeInit call s:attempt_select_last_file()

let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeMapUpdir="-"
let g:NERDTreeMapCustomOpen="l"
let g:NERDTreeMapCloseDir="h"
let g:NERDTreeIgnore=["*.pyc", "__pycache__"]
let NERDTreeCreatePrefix='silent keepalt keepjumps'
let g:NERDTreeCustomOpenArgs={'file': {'reuse': ''}, 'dir': {}}

" emulate vim-vinegar
nnoremap <silent> - :edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
