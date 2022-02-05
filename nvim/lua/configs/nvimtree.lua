local tree = TP.require('nvim-tree')
local g = vim.g

tree.setup{
filters = {
      dotfiles = false,
      custom = {
        ".git",
        "node_modules",
        ".cache",
      },
    },
ignore_ft_on_setup = {
      "dashboard",
      "startify",
      "alpha",
    },
    auto_close = true,
    open_on_tab = false,
  diagnostics = {
      enable = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },

 disable_netrw = true,
    hijack_netrw = true,
        quit_on_open = true,
    hijack_cursor = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
  },
  git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 0,
      tree_width = 30,
    },
  view = {
    side = "right",
    auto_resize = true,
    width = 30,

  },
}

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
      deleted = "",
      ignored = "◌",
      renamed = "➜",
      staged = "✓",
      unmerged = "",
      unstaged = "✗",
      untracked = "★",
    },
    folder = {
      default = "",
      empty = "",
      empty_open = "",
      open = "",
      symlink = "",
      symlink_open = "",
    },
  }
  g.nvim_tree_indent_markers = 1
