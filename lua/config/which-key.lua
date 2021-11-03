local wk = require('which-key')

-- Initialize
wk.setup {}

wk.register({
  e = {'<cmd>NvimTreeToggle<CR>', 'File Explorer'},
}, {prefix = '<leader>'})

