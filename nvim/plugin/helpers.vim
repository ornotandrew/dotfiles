" Read in 12 random hex chars
noremap <silent> <Leader>u "=system('uuidgen \| tr -d " \\t\n-" \| tr "[:upper:]" "[:lower:]"')<CR>p
