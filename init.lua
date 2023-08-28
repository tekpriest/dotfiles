vim.loader.enable()

if vim.g.vscode then
  require 'tp.options'
  require 'tp.mappings'
else
  require 'tp.mappings'
  require 'tp.lazy'
  require 'tp.options'
  require 'tp.highlights'
  require 'tp.autocmds'
  require 'tp.lsp'
end
