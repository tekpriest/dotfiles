local tree_cb = require('nvim-tree.config').nvim_tree_callback
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

require('nvim-tree').setup {
  disable_netrw = false,
  hijack_netrw = true,
  hijack_cursor = true,
  respect_buf_cwd = false,
  sync_root_with_cwd = true,
  filters = {
    dotfiles = false,
  },
  diagnostics = { enable = true },
  git = { enable = true, ignore = true },
  update_focused_file = {
    enable = false,
    update_root = true,
    ignore_list = { 'help' },
  },
  live_filter = {
    always_show_folders = false,
  },
  view = {
    side = 'right',
    width = 30,
  },
  actions = {
    change_dir = {
      global = true,
    },
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    icons = {
      git_placement = 'after',
      glyphs = {
        git = {
          unstaged = '',
          staged = '',
          unmerged = '',
          renamed = '',
          untracked = '',
          deleted = '',
          ignored = '',
        },
        folder = {
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = '',
          symlink_open = '',
        },
      },
    },
  },
}

-- map('n', '<leader>o', '<cmd>NvimTreeFindFile<CR>', opts)
-- map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'NvimTree: toggle' })
vim.keymap.set('n', '<leader>o', '<cmd>NvimTreeFindFile!<CR>', { desc = 'NvimTree: find file' })
