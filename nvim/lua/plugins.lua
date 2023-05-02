local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use { "wbthomason/packer.nvim" }

  use 'chriskempson/base16-vim'

  use 'bronson/vim-visual-star-search'
  use 'itchyny/lightline.vim'
  use 'rickhowe/diffchar.vim'
  use 'chrisbra/Colorizer'

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sensible'
  -- use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'

  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }

  -- buffer/file management
  use { 'Shougo/defx.nvim', run = ':UpdateRemotePlugins' }
  use 'kristijanhusak/defx-icons'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- telescope
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'

  use 'sjl/gundo.vim'

  use 'windwp/nvim-autopairs'

  use 'nvim-lua/lsp-status.nvim'

  -- completion
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'andersevenrud/cmp-tmux'
  use 'hrsh7th/nvim-cmp'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'lukas-reineke/lsp-format.nvim'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    commit = '48a3da710369688df80beb2847dabbbd02e2180e',
    lock = true,
    run = ':TSUpdate',
  }
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-context'

  -- language support
  use 'pangloss/vim-javascript'
  use 'hail2u/vim-css3-syntax'
  use 'hynek/vim-python-pep8-indent'
  use 'jparise/vim-graphql'
  use 'kylef/apiblueprint.vim'
  use 'maxmellon/vim-jsx-pretty'
  use 'othree/html5.vim'
  use 'ap/vim-css-color'
  use 'hashivim/vim-terraform'
  use 'cappyzawa/starlark.vim'
  use 'mechatroner/rainbow_csv'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
