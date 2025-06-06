return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-tree/nvim-web-devicons',
        opts = { default = true }
      },
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local actions = require('telescope.actions')
      local builtin = require('telescope.builtin')
      -- local themes = require('telescope.themes')
      local util = require('wraithy.util')
      local custom_pickers = require('wraithy.telescope.pickers')

      require('telescope').setup({
        defaults = {
          color_devicons = true,
          file_previewer = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
          mappings = {
            n = {
              ["<C-q>"] = actions.send_to_qflist,
              ["<C-Enter>"] = actions.to_fuzzy_refine,
            },
            i = {
              ["<C-q>"] = actions.send_to_qflist,
              ["<C-Enter>"] = actions.to_fuzzy_refine,
            },
          },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_cursor() }
        }
      })
      require('telescope').load_extension('fzy_native')
      require("telescope").load_extension("ui-select")


      util.set_leader_map('f', custom_pickers.find_files())
      util.set_leader_map('F', custom_pickers.find_files({ path_display = { 'shorten' } }))
      util.set_leader_map('d', custom_pickers.find_files({ cwd = '~/.config/nvim/' }))
      util.set_leader_map('R', builtin.grep_string)
      util.set_leader_map('r', builtin.live_grep)
      util.set_leader_map('b', builtin.buffers)
      util.set_leader_map('s', custom_pickers.find_files({ cwd = '~/code/stitch/src/shared/' }))
      vim.keymap.set(
        { 'n', 'v' },
        '<leader>c',
        custom_pickers.ai_action_palette,
        { noremap = true }
      )
    end
  },
}
