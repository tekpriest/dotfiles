--- Install lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
    { import = 'plugins' },
    { import = 'plugins.langs' },
  },
  {
    defaults = { lazy = true, version = nil },
    change_detection = { notify = false, enabled = true },
    install = { missing = true, colorscheme = { 'tokyonight', 'catppuccin' } },
    checker = { enabled = true, notify = false }, -- automatically check for plugin updates
    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          'gzip',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
          'rplugin',
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
