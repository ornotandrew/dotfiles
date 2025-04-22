local M = {}

function M.ensure_directory_exists(dir)
  local full_path = vim.fn.expand(dir)
  os.execute('mkdir -p ' .. full_path)
  return full_path
end

function M.merge_tables(...)
  local t_new = {}
  for _, given_table in ipairs({ ... }) do
    for k, v in pairs(given_table) do t_new[k] = v end
  end
  return t_new
end

function M.keys(table)
  local keys = {}
  for k, _ in pairs(table) do
    keys[#keys + 1] = k
  end
  return keys
end

function M.set_spaces_per_tab(n)
  vim.opt_local.tabstop = n
  vim.opt_local.shiftwidth = n
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

--- NOTE: This only works _after_ we've left visual mode
--- @return table { start: number, stop: number }
function M.get_previous_visual_selection_rows()
  local start = vim.fn.getpos("'<'")
  local start_row = start[2]
  local stop = vim.fn.getpos("'>'")
  local stop_row = stop[2]

  if start_row < stop_row then
    return { start = start_row, stop = stop_row }
  else
    return { start = stop_row, stop = start_row }
  end
end

M.set_leader_map = function(key, fn)
  vim.keymap.set(
    'n',
    '<leader>' .. key,
    fn,
    { noremap = true }
  )
end

function M.shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

return M
