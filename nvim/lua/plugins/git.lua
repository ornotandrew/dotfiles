return {
  {
    'https://github.com/lewis6991/gitsigns.nvim',
    version = '*',
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<cr>', { desc = 'Next git change' })
      vim.keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'Previous git change' })
    end,
  },
  {
    'tpope/vim-fugitive',
    version = '*'
  }
}
