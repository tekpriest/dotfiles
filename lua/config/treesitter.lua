setmetatable(_G, {__index=vim})
local ts = require('nvim-treesitter')

do -- Treesitter
  opt.foldmethod = "expr"
  opt.foldexpr = "nvim_treesitter#foldexpr()"
  require('nvim-treesitter.configs').setup {
    ensure_installed = {"javascript","lua","html"},
    highlight = {enable = true},
    indent = {enable = true},
    textobjects = {
      select = {
        enable = true,
        keymaps = {
           ac = '@call.outer',
           af = '@function.outer',
           ak = '@conditional.outer',
           at = '@class.outer'
        }
      }
    }
  }
end
