lua <<EOF
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
EOF

highlight link TSVariable Normal
highlight link TSMethod Function

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
