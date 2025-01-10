-- Read in 12 random hex chars
local function generate_uuid(with_dashes)
  local chars
  if (with_dashes) then
    chars = io.popen('uuidgen | tr -d " \t\n" | tr "[:upper:]" "[:lower:]"'):read('*a')
  else
    chars = io.popen('uuidgen | tr -d " \t\n-" | tr "[:upper:]" "[:lower:]"'):read('*a')
  end
  vim.fn.setreg('"', chars)
  return vim.api.nvim_command('norm! ""p')
end

vim.keymap.set('n', '<Leader>u', function() generate_uuid(false) end, { noremap = true })
vim.keymap.set('n', '<Leader>U', function() generate_uuid(true) end, { noremap = true })

-- Copy a link to the Stitch repo, based on the currently selected line(s)
local function yank_stitch_repo_link()
  local currentLine = vim.fn.getpos('.')[2]
  local startOfSelection = vim.fn.getpos('v')[2]

  local p0, p1 = math.min(currentLine, startOfSelection), math.max(currentLine, startOfSelection)

  local path = string.gsub(vim.fn.expand('%:p'), "^.*/stitch/", "")

  local url = "https://github.com/Stitch-Money/stitch/blob/main/" .. path .. "#" .. "L" .. p0

  if p0 ~= p1 then
    url = url .. "-L" .. p1
  end
  vim.fn.setreg('+', url)
end

vim.keymap.set('n', '<Leader>S', yank_stitch_repo_link, { noremap = true })
vim.keymap.set('v', '<Leader>S', yank_stitch_repo_link, { noremap = true })

-- Copy the path of the current file to the clipboard
vim.keymap.set('n', '<Leader>p', ":let @*=expand('%')<CR>", { noremap = true, silent = true })
