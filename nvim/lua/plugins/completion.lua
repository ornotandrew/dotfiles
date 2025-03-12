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
      'milanglacier/minuet-ai.nvim',
      config = function()
        require('minuet').setup {
          provider = 'openai_fim_compatible',
          n_completions = 2, -- recommend for local model for resource saving
          -- I recommend beginning with a small context window size and incrementally
          -- expanding it, depending on your local computing power. A context window
          -- of 512, serves as an good starting point to estimate your computing
          -- power. Once you have a reliable estimate of your local computing power,
          -- you should adjust the context window to a larger value.
          context_window = 2048,
          add_single_line_entry = false,
          provider_options = {
            openai_fim_compatible = {
              api_key = 'TERM',
              name = 'Ollama',
              end_point = 'http://localhost:11434/v1/completions',
              model = 'qwen2.5-coder',
              stream = true,
              optional = {
                max_tokens = 1024,
                top_p = 0.9,
              },
            },
            claude = {
              max_tokens = 512,
              model = 'claude-3-7-sonnet-20250219',
              stream = true,
              api_key = 'ANTHROPIC_API_KEY',
            },
          },
        }
      end,
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local util = require("wraithy.util")
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
        ['<C-CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
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
        { name = 'nvim_lsp', max_item_count = 3, keyword_length = 2 },
        -- { name = 'minuet',   max_item_count = 2 },
        { name = "luasnip",  max_item_count = 2 },
      }, {
        { name = 'buffer', max_item_count = 2 },
        { name = 'path',   max_item_count = 2 },
        { name = 'tmux',   keyword_length = 3 },
      }),
      performance = {
        fetching_timeout = 2000,
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol',
          maxwidth = 50,
          ellipsis_char = '...',
          symbol_map = util.merge_tables(lspkind.presets.default, { Ollama = '󰳆', })
        }),
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
