return {
  'nvim-neorg/neorg',
  enabled = false,
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = '*', -- Pin Neorg to the latest stable release
  build = ':Neorg sync-parsers',
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = {},
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/Code/notes',
          },
          default_workspace = 'notes',
        },
      },
      ['core.integrations.treesitter'] = {},
      ['core.syntax'] = {},
      ['core.summary'] = {},
    },
  },
}
