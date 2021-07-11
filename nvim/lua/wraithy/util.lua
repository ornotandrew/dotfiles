local M = {}

function M.ensure_directory_exists(dir)
  os.execute('mkdir -p ' .. dir)
end

function M.set_spaces_per_tab(n)
  vim.opt_local.tabstop = n
  vim.opt_local.shiftwidth = n
end

function M.t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
