return {
  'williamboman/mason.nvim',
  build = ':MasonUpdate', -- :MasonUpdate updates registry contents
  opts = {
    ui = {
      border = 'double',
      icons = {
        package_installed = '﫟',
        package_pending = '﫠',
        package_uninstalled = '',
      },
    },
  },
}
