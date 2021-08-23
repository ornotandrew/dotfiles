" Plugins {{{
" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    exec 'silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'chriskempson/base16-vim'

Plug 'bronson/vim-visual-star-search'
Plug 'itchyny/lightline.vim'
Plug 'rickhowe/diffchar.vim'
Plug 'chrisbra/Colorizer'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" buffer/file management
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'sjl/gundo.vim'

Plug 'windwp/nvim-autopairs'

" completion
Plug 'hrsh7th/nvim-compe'
Plug 'andersevenrud/compe-tmux'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'


" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

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
Plug 'nvim-treesitter/nvim-treesitter-angular'

call plug#end()

" }}}

augroup custom
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

let mapleader = "\<space>" 
let localleader="\\"

colorscheme base16-default-dark " the theme clears all highlights, we set this here so we can define custom ones later on


let loaded_netrwPlugin = 1 " don't load netrw
lua require("wraithy.lsp")

" vim:foldmethod=marker:foldlevel=0
