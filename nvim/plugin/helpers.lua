-- Read in 12 random hex chars
function _G.generate_uuid()
  local chars = io.popen('uuidgen | tr -d " \t\n-" | tr "[:upper:]" "[:lower:]"'):read('*a')
  vim.fn.setreg('"', chars)
  return vim.api.nvim_command('norm! ""p')
end

vim.api.nvim_set_keymap('n', '<Leader>u', ':call v:lua.generate_uuid()<CR>', {noremap=true})

-- Copy the path of the current file to the clipboard
vim.api.nvim_set_keymap('n', '<Leader>p', ":let @*=expand('%')<CR>", {noremap=true, silent=true})
