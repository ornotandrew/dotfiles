lua require("plugins")

let mapleader = "\<space>" 
let localleader="\\"

colorscheme base16-default-dark " the theme clears all highlights, we set this here so we can define custom ones later on


let loaded_netrwPlugin = 1 " don't load netrw
lua require("wraithy.lsp")


" vim:foldmethod=marker:foldlevel=0
