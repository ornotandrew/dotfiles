require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  -- indent = {
  --   enable = true,
  -- },
  highlight = {
    enable = true,
    disable = {},
    custom_captures = {
      ["keyword.operator"] = "Keyword",
    },
  },
}

-- NOTE: The highlight command is not yet supported. See https://github.com/neovim/neovim/issues/9876
vim.api.nvim_command('highlight link TSVariable Normal')
vim.api.nvim_command('highlight link TSMethod Function')
