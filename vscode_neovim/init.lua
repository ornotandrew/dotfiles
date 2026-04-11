-- Make sure that the runtimepath is isolated to the separate vscode folder
local new_rtp = vim.tbl_filter(function(path)
  return not string.find(path, "andrew/.config/nvim")
end, vim.api.nvim_list_runtime_paths())
table.insert(new_rtp, 1, "/Users/andrew/github/dotfiles/vscode_neovim")
vim.opt.rtp = table.concat(new_rtp, ",")

-- Setup leader. It's important to do this before loading lazy.nvim
vim.g.mapleader = " "
vim.g.localleader = "\\"

require("config")
