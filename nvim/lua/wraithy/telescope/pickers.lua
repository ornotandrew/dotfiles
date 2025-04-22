local util = require('wraithy.util')

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require('telescope.builtin')
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local themes = require('telescope.themes')

local M = {}

M.set_leader_map = function(key, fn)
  vim.keymap.set(
    'n',
    '<leader>' .. key,
    fn,
    { noremap = true }
  )
end

M.find_files = function(extra_options)
  return function()
    local opts = {
      previewer = false,
      layout_config = { width = 120 }
    }
    require('telescope.builtin').find_files(themes.get_dropdown(util.merge_tables(opts, extra_options)))
  end
end

M.lsp_references = function()
  builtin.lsp_references(themes.get_dropdown({ layout_config = { width = 120 } }))
end

M.ai_action_palette = function(opts)
  opts = opts or {}

  local codecompanion = require('codecompanion')

  local mode = vim.api.nvim_get_mode()['mode']
  local is_visual = mode == "V" or mode == "v"
  if is_visual then
    -- get out of visual mode so that vim saves the '< and '> marks
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), 'x', true)
  end
  pickers.new(opts, {
    prompt_title = "AI Chat",
    finder = finders.new_table {
      results = {
        { "Chat - Claude",                  { codecompanion.chat, { fargs = { "anthropic" } } } },
        { "Chat - Claude (Haiku)",          { codecompanion.chat, { fargs = { "anthropic_haiku" } } } },
        { "Chat - Ollama (deepseek-r1:8b)", { codecompanion.chat, { fargs = { "ollama_deepseek" } } } },
        { "Chat - Ollama (qwen2.5-coder)",  { codecompanion.chat, { fargs = { "ollama_qwen" } } } },
        { "Chat - Ollama (qwq)",            { codecompanion.chat, { fargs = { "ollama_qwq" } } } },
        { "Other actions",                  { codecompanion.actions, {} } },
      },
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1],
          ordinal = entry[1],
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        local fn = selection.value[2][1]
        local args = util.shallow_copy(selection.value[2][2])
        if is_visual then
          -- CodeCompanion will use this as a trigger to figure out the previous visual selection
          -- based on '< and '>
          args['range'] = 1
        end
        fn(args)
      end)
      return true
    end,
  }):find()
end

return M
