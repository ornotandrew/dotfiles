return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
    { 'echasnovski/mini.nvim', version = '*' },
  },
  opts = {
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
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
  },
  adapters = {
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "ollama",
        schema = {
          model = {
            default = "qwen2.5-coder",
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
  }
}
