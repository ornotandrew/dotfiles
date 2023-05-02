" General
nmap <Leader><Space> :noh<CR>
nmap <Leader>l :setlocal list!<CR>
nmap <Leader>q :cwindow<CR>
nmap <Leader>w :setlocal wrap!<CR>
nmap <Leader>z :setlocal foldenable!<CR>
nmap <silent> gx :execute 'silent! !open ' . shellescape(expand('<cWORD>'), 1)<cr>
nnoremap Y y$
nmap <silent> <Leader>] :vsp<CR><C-]>

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

" Terminal
tmap <Esc> <C-\><C-n>
