local wk = require('which-key')

-- Plugins to use
require('config.nvim-tree')

wk.setup {}

wk.register({
  e = {'<cmd>NvimTreeToggle<CR>', 'File Explorer'},
  f = {"<cmd>lua require('telescope.builtin').find_files()<CR>", 'Recent files'},
  b = {'<cmd>Telescope buffers<CR>', 'Recent buffers'},
  s = {
    name = "session",
    l = {"cmd>lua require('persistence').load()<cr>", 'load session'},
  }
}, {prefix = "<leader>"})

return wk
