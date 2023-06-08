return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/playground' },
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
          'sql'
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = true,
        },
        -- playground = { enable = true, },
        indent = { enable = true },
        query_linter = { enable = true },
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = {
        --     -- mappings for incremental selection (visual mappings)
        --     init_selection = "<CR>",    -- maps in normal mode to init the node/scope selection
        --     node_incremental = "<CR>",  -- increment to the upper named parent
        --     scope_incremental = "<CR>", -- increment to the upper scope (as defined in locals.scm)
        --     node_decremental = "<CR>"   -- decrement to the previous node
        --   }
        -- },
      }
    end,
  },
}
