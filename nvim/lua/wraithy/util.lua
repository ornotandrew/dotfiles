local M = {}

function M.ensure_directory_exists(dir)
  local full_path = vim.fn.expand(dir)
  os.execute('mkdir -p ' .. full_path)
  return full_path
end

function M.set_spaces_per_tab(n)
  vim.opt_local.tabstop = n
  vim.opt_local.shiftwidth = n
end

function M.t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
