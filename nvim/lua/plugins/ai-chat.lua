return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
    { 'echasnovski/mini.nvim', version = '*' },
    "j-hui/fidget.nvim",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest",
      config = function()
        require("mcphub").setup({
          port = 3042,
          config = vim.fn.expand("~/.config/mcp/mcpservers.json"),
        })
      end
    }
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
          tools = {
            ["mcp"] = {
              callback = require("mcphub.extensions.codecompanion"),
              description = "Call tools and resources from the MCP Servers",
              opts = {
                requires_approval = true,
              },
            },
          },
        },
        inline = {
          adapter = "anthropic",
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama",
            schema = {
              model = {
                default = "deepseek-r1:8b",
                -- default = "qwen2.5-coder",
              },
              num_ctx = {
                default = 16384,
              },
              num_predict = {
                default = -1,
              },
            },
          })
        end,
      },
      display = {
        action_palette = {
          width = 50,
          height = 5,
          prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
          provider = "telescope",               -- default|telescope|mini_pick
          opts = {
            show_default_actions = true,        -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          -- layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
        }
      },
    })
  end,
  init = function()
    require("wraithy.codecompanion-progress"):init()
  end,
}
