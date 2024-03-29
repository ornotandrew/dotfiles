return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    end
  end,
  config = function(_, opts)
    require('lualine').setup(opts)
    vim.o.showtabline = 1
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus
    return {
      options = {
        theme = "base16",
        globalstatus = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
      },
      disabled_filetypes = {
        statusline = { "TelescopePrompt" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "diagnostics",
          { "filename", path = 1, }
        },
        lualine_c = {},
        lualine_x = {
          "encoding",
          { "filetype", colored = false }
        },
        lualine_y = {
          { "progress" },
        },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = { { "filename", path = 0 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = {
          {
            'tabs',
            max_length = vim.o.columns,
            mode = 1,
            path = 0,
            use_mode_colors = true
          }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }
    }
  end,
}
