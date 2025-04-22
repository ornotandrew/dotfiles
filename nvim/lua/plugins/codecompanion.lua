function ollama_adaptor(model_name, ctx_window)
  ---@diagnostic disable-next-line: redefined-local
  local ctx_window = ctx_window or 16384
  return require("codecompanion.adapters").extend("ollama", {
    name = "ollama_" .. model_name,
    formatted_name = "Ollama - " .. model_name,
    schema = {
      model = {
        default = model_name,
      },
      num_ctx = {
        default = ctx_window,
      },
      num_predict = {
        default = -1,
      },
    },
  })
end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
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
          slash_commands = {
            ["file"] = {
              -- Location to the slash command in CodeCompanion
              callback = "strategies.chat.slash_commands.file",
              description = "Select a file using Telescope",
              opts = {
                provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                contains_code = true,
              },
            },
          }
        },
        inline = {
          -- TODO: switch to anthropic once inline is working
          -- https://github.com/olimorris/codecompanion.nvim/discussions/1109
          adapter = "openai",
        },
      },
      adapters = {
        ollama_deepseek = ollama_adaptor("deepseek-r1:8b", 40000),
        ollama_qwen = ollama_adaptor("qwen2.5-coder"),
        ollama_qwq = ollama_adaptor("qwq"),
        anthropic_haiku = function()
          return require("codecompanion.adapters").extend("anthropic", {
            name = "anthropic_haiku",
            formatted_name = "Anthropic - Haiku",
            schema = {
              model = {
                default = "claude-3-5-haiku-20241022",
              },
            },
          })
        end,
      },
      display = {
        action_palette = {
          width = 50,
          height = 7,
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
        },
      },
      prompt_library = {
        ["Refactor this  file"] = {
          strategy = "chat",
          description = "Refactor the current file",
          opts = {
            index = 1,
            is_default = false,
            is_slash_cmd = true,
            short_name = "refactor",
            auto_submit = false,
          },
          prompts = {
            {
              role = "user",
              content = "Use @editor to refactor the code in #buffer{watch}.\n\n"
            },
          }
        },
        ["Outline this file"] = {
          strategy = "chat",
          description = "Summarize the function definitions and behaviours in the current file",
          opts = {
            index = 2,
            is_default = false,
            is_slash_cmd = true,
            short_name = "outline",
            auto_submit = false,
          },
          prompts = {
            {
              role = "system",
              content = function(context)
                return string.format([[You are an expert %s developer.
I am also an expert %s developer and will ask you specific questions.
When answering me, condense your answers to contain only the most critical information. Do not include trivial details that I might already know.
If you are asked to summarize code, but not given any code, do not do anything except ask for the code."]],
                  context.filetype, context.filetype)
              end
            },
            {
              role = "user",
              content = [[Summarize the given code.

Begin with a short, 1-paragraph description of how the code might fit into a larger codebase.

Continue with a high-level outline of classes, functions, methods etc. Give me no more than 5 paragraphs. In cases where there are more than 5 items, include the most important ones and add an additional paragraph listing the items that were excluded without any description.

Continue with examples of how the code might be invoked and results that might be returned.]]
            }
          }
        }
      }
    })
  end,
}
