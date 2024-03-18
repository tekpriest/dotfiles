local g, opt = vim.g, vim.opt

-- disable autoformat
g.autoformat = false
opt.autowrite = false
opt.cursorline = false

for _, provider in pairs { 'node', 'perl', 'python3', 'ruby' } do
  g['loaded_' .. provider .. '_provider'] = 0
end

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  'loaded',
  'loaded_gzip',
  'loaded_man',
  'loaded_matchit',
  'loaded_matchparen',
  'loaded_shada_plugin',
  'loaded_tar',
  'loaded_tarPlugin',
  'loaded_zipPlugin',
  'loaded_zip',
  'loaded_netrwPlugin',
}

for i = 1, 10 do
  g[disabled_built_ins[i]] = 1
end

if g.neovide then require 'config.neovide' end
