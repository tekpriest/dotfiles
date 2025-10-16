return {
  'nvimtools/none-ls.nvim',
  optional = true,
  opts = function(_, opts)
    local nls = require 'null-ls'
    opts.sources = opts.sources or {}
    table.insert(opts.sources, nls.builtins.formatting.prettierd)
    table.insert(opts.sources, nls.builtins.formatting.stylua)
    -- table.insert(opts.sources, nls.builtins.formatting.mix)
  end,
}
