return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- 'HiPhish/nvim-ts-rainbow2',
      'JoosepAlviste/nvim-ts-context-commentstring',
      -- {
      --   'andymass/vim-matchup',
      --   init = function()
      --     vim.g.matchup_matchparen_offscreen = { method = 'popup' }
      --   end,
      -- },
    },
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'lua',
          'vim',
          'javascript',
          'typescript',
          'prisma',
          'go',
          'json',
          'yaml',
          'gomod',
          'terraform',
          'sql',
          'cpp',
          'vimdoc',
          'c',
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            -- mappings for incremental selection (visual mappings)
            init_selection = '<CR>', -- maps in normal mode to init the node/scope selection
            node_incremental = '<CR>', -- increment to the upper named parent
            scope_incremental = '<CR>', -- increment to the upper scope (as defined in locals.scm)
            node_decremental = '<CR>', -- decrement to the previous node
          },
        },
        -- rainbow = {
        --   enable = true,
        -- },
        context_commentstring = {
          enable = true,
        },
        -- matchup = {
        --   enable = true,
        -- },
      }
    end,
  },
}
