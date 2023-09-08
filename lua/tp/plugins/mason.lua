return {
  'williamboman/mason.nvim',
  build = ':MasonUpdate', -- :MasonUpdate updates registry contents
  opts = {
    ui = {
      border = 'double',
      icons = {
        package_installed = '﫟',
        package_pending = ' ',
        package_uninstalled = '',
      },
    },
    ensure_installed = {
  'bashls',
  'cssls',
  'docker_compose_language_service',
  'dockerls',
  'emmet_ls',
  'gopls',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'prismals',
  'svelte',
  'tailwindcss',
  'taplo',
  'terraformls',
  'tsserver',
  'yamlls',
  'pyright',
  'eslint-lsp',
    }
  },
}
