local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local nvim_tree_config = require"nvim-tree.config"

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup{
  view = {
    side = 'right',
    hide_root_folder = false,
     mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "s", cb = tree_cb "split" },
      },
    },
  },
  filters = {
    dotfiles = false,
        custom = {
      ".git",
      "node_modules",
      "dist",
      ".cache",
    },
  },
  open_on_tab = false,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  disable_netrw = true,
  hijack_netrw = true,
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
}
