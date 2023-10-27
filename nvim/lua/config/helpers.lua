-- Read in 12 random hex chars
local function generate_uuid()
  local chars = io.popen('uuidgen | tr -d " \t\n-" | tr "[:upper:]" "[:lower:]"'):read('*a')
  vim.fn.setreg('"', chars)
  return vim.api.nvim_command('norm! ""p')
end

vim.keymap.set('n', '<Leader>u', generate_uuid, {noremap=true})

-- Copy the path of the current file to the clipboard
vim.keymap.set('n', '<Leader>p', ":let @*=expand('%')<CR>", {noremap=true, silent=true})
