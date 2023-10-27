local floating_window_border = 'rounded'

local M = {}

local float_opts = { border=floating_window_border, focusable = false }

M.open_float = function() vim.diagnostic.open_float(float_opts) end
M.goto_prev = function() vim.diagnostic.goto_prev({float=float_opts}) end
M.goto_next = function() vim.diagnostic.goto_next({float=float_opts}) end

return M
