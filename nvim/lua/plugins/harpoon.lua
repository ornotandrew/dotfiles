return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<C-g>", function() harpoon:list():append() end)
    vim.keymap.set("n", "<leader>g", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end)
    return {}
  end
}
