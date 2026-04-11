local M = {}

-- Returns (start, end)
function M.get_visual_selection_range()
  local currentLine = vim.fn.getpos('.')[2]
  local startOfSelection = vim.fn.getpos('v')[2]
  return math.min(currentLine, startOfSelection), math.max(currentLine, startOfSelection)
end

function M.is_visualish_mode()
  local mode = vim.fn.mode()
  return mode == 'v' or mode == 'V' or mode == '\22' -- '\22' is <C-V> (visual block)
end

return M
