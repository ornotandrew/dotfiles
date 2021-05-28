" NOTE: This file lives in nvim/plugin because it needs to run BEFORE anything else
let base16colorspace=256
" having a bright red background is really distracting
highlight SpellBad guibg=NONE
highlight SpellCap guibg=NONE
highlight Error guibg=NONE guifg=NONE
" use the contextual background instead of always being black
highlight Normal guibg=NONE
" make search highlights blend in, while still being visible at a glance
highlight Search guifg=guifg guibg=guibg gui=bold,underline
highlight! link IncSearch Search
