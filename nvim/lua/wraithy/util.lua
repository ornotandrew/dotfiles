local M = {}

function M.ensure_directory_exists(dir)
  local full_path = vim.fn.expand(dir)
  os.execute('mkdir -p ' .. full_path)
  return full_path
end

function M.merge_tables(...)
  local t_new = {}
  for _, given_table in ipairs({...}) do
    for k,v in pairs(given_table) do t_new[k] = v end
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

return M
