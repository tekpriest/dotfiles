local compe = require('compe')
local keymap = require('.keymappings')
compe.setup {
  min_length = 2;
  preselect = "disable";
  source = {
    path = true,
    tags = true,
    omni = {filetypes = {"tex"}},
    spell = {filetypes = {"markdown", "tex"}},
    buffer = true,
    nvim_lsp = true,
  }
}
keymap.keymap({mode="i", opts={expr=true}}, {
  ["<Tab>"] = "pumvisible() ? '<C-n>' : <Tab>",
  ["<S-Tab>"] = "pumvisible() ? '<C-p>' : '<S-Tab>'",
})
