return {
  'stevearc/oil.nvim',
  opts = function()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    return {
      delete_to_trash = true,
      use_default_keymaps = false,
      view_options = {
        show_hidden = true
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["gc"] = "actions.cd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      }
    }
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
