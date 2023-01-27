require('indent_blankline').setup({
  buftype_exclude = {"terminal", "prompt", "nofile"},
  filetype_exclude = {
    'help', 'dashboard', 'Trouble', 'dap.*', 'NvimTree',
    "packer"
  },
  show_current_context = true,
  show_current_context_start = false,
  show_end_of_line = true,
})
