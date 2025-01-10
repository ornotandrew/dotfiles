return {
  'RRethy/nvim-base16',
  lazy = false,
  config = function()
    local base16 = require('base16-colorscheme')
    -- default-dark
    local colors = require("wraithy.colors")

    base16.with_config({
      telescope = true,
      telescope_borders = true,
      cmp = true,
    })

    base16.setup(colors)
    base16.highlight.LineNr                = { guifg = colors.base03, guibg = colors.base01, gui = nil, guisp = nil }
    base16.highlight.SignColumn            = { guifg = colors.base03, guibg = colors.base01, gui = nil, guisp = nil }
    base16.highlight.VertSplit             = { guifg = colors.base02, guibg = colors.base02, gui = nil, guisp = nil }

    -- the default cmp colors are a bit ugly
    base16.highlight.CmpItemAbbr           = { guifg = colors.base05, guibg = nil, gui = nil, guisp = nil }
    base16.highlight.CmpItemAbbrMatch      = { guifg = colors.base04, guibg = nil, gui = nil, guisp = nil }
    base16.highlight.CmpItemAbbrMatchFuzzy = { guifg = colors.base04, guibg = nil, gui = nil, guisp = nil }

    -- NOTE: The highlight command is not yet supported. See https://github.com/neovim/neovim/issues/9876

    -- having a bright red background is really distracting
    vim.api.nvim_command('highlight SpellBad guibg=NONE')
    vim.api.nvim_command('highlight SpellCap guibg=NONE')
    vim.api.nvim_command('highlight Error guibg=NONE guifg=NONE')

    -- use the contextual background instead of always being black
    vim.api.nvim_command('highlight Normal guibg=NONE')

    -- make search highlights blend in, while still being visible at a glance
    vim.api.nvim_command('highlight Search guifg=guifg guibg=guibg gui=bold,italic,underline')
    vim.api.nvim_command('highlight! link IncSearch Search')
    vim.api.nvim_command('highlight! link CurSearch Search')

    -- floating windows
    vim.api.nvim_command('highlight NormalFloat guibg=none')
    vim.api.nvim_command('highlight FloatBorder guifg=#b8b8b8')
  end
}
