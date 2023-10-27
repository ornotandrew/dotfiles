return {
  'RRethy/nvim-base16',
  lazy = false,
  config = function()
    local base16 = require('base16-colorscheme')
    -- default-dark
    local colors = {
      base00 = '#181818',
      base01 = '#282828',
      base02 = '#383838',
      base03 = '#585858',
      base04 = '#b8b8b8',
      base05 = '#d8d8d8',
      base06 = '#e8e8e8',
      base07 = '#f8f8f8',
      base08 = '#ab4642',
      base09 = '#dc9656',
      base0A = '#f7ca88',
      base0B = '#a1b56c',
      base0C = '#86c1b9',
      base0D = '#7cafc2',
      base0E = '#ba8baf',
      base0F = '#a16946'
    }

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
    vim.api.nvim_command('highlight Search guifg=guifg guibg=guibg gui=bold,underline')
    vim.api.nvim_command('highlight! link IncSearch Search')

    -- floating windows
    vim.api.nvim_command('highlight NormalFloat guibg=none')
    vim.api.nvim_command('highlight FloatBorder guifg=#b8b8b8')
  end
}
