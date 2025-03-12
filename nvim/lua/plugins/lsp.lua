return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'lukas-reineke/lsp-format.nvim',
  },
  config = function()
    require('lsp')
  end
}
