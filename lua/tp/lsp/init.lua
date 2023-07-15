local ok, _ = pcall(require, 'lspconfig')
if not ok then
  return
end

local dev_ok, dev = pcall(require, 'neodev')
if not dev_ok then
  return
end

-- load neodev
dev.setup {}

require 'tp.lsp.mason'
require('tp.lsp.setup').setup()
-- require 'tp.lsp.null-ls'
