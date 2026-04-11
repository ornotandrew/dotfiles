local util = require('wraithy.util')

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

local M = {}

-- Common theme configuration
local dropdown_config = { layout_config = { width = 120 } }

local function get_dropdown_theme(extra_opts)
  return themes.get_dropdown(util.merge_tables(dropdown_config, extra_opts or {}))
end

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
    local opts = { previewer = false }
    require('telescope.builtin').find_files(get_dropdown_theme(util.merge_tables(opts, extra_options)))
  end
end

M.lsp_references = function()
  builtin.lsp_references(get_dropdown_theme())
end

M.lsp_actions = function()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local lsp_actions = {
    { name = "Find References", fn = M.lsp_references },
    {
      name = "Find Implementations",
      fn = function()
        builtin.lsp_implementations(get_dropdown_theme())
      end
    },
    {
      name = "Find Type Definition",
      fn = function()
        builtin.lsp_type_definitions(get_dropdown_theme())
      end
    },
    {
      name = "Incoming Calls",
      fn = function()
        builtin.lsp_incoming_calls(get_dropdown_theme())
      end
    },
    {
      name = "Outgoing Calls",
      fn = function()
        builtin.lsp_outgoing_calls(get_dropdown_theme())
      end
    },
    {
      name = "Document Symbols",
      fn = function()
        builtin.lsp_document_symbols(get_dropdown_theme())
      end
    },
    {
      name = "Workspace Symbols",
      fn = function()
        builtin.lsp_workspace_symbols(get_dropdown_theme())
      end
    },
    { name = "Format",          fn = function() vim.lsp.buf.format({ async = true }) end },
  }

  pickers.new(get_dropdown_theme(), {
    prompt_title = "LSP Actions",
    finder = finders.new_table({
      results = lsp_actions,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        selection.value.fn()
      end)
      return true
    end,
  }):find()
end

return M
