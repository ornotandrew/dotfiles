local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    'hrsh7th/cmp-cmdline',
    'andersevenrud/cmp-tmux',
    {
      "zbirenbaum/copilot-cmp",
      dependencies = "copilot.lua",
      opts = {},
    }
  },
  config = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local lspkind = require('lspkind')

    cmp.setup({
      enabled = function()
        if vim.api.nvim_buf_get_option(0, 'filetype') == 'TelescopePrompt' then
          return false
        end
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
        end
      end,
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item()
          else
            fallback()
          end
        end),
        ['<S-Tab>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          end
        end),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp', max_item_count = 5, keyword_length = 2 },
        { name = 'copilot',  max_item_count = 2, keyword_length = 0 },
        { name = "luasnip",  max_item_count = 2 },
      }, {
        { name = 'buffer', max_item_count = 2 },
        { name = 'path',   max_item_count = 2 },
        { name = 'tmux',   keyword_length = 3 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'text',
          maxwidth = 50,
          ellipsis_char = '...',
        })
      },
      experimental = {
        ghost_text = false,
      },
      sorting = defaults.sorting,
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer', max_item_count = 3 }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path', max_item_count = 3 }
      }, {
        { name = 'cmdline', max_item_count = 3 }
      })
    })
  end,
}
