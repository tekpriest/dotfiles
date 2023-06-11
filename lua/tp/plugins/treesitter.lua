return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'HiPhish/nvim-ts-rainbow2',
      'JoosepAlviste/nvim-ts-context-commentstring',
      {
        'andymass/vim-matchup',
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
      },
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
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          use_languagetree = true,
        },
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
        refactor = {
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = '<leader>gd',
              list_definitions = '<leader>gD',
              list_definitions_toc = '<leader>gO',
              goto_next_usage = '<a-*>',
              goto_previous_usage = '<a-#>',
            },
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = 'gr',
            },
          },
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
        },
        rainbow = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
        },
        matchup = {
          enable = true,
        },
      }
    end,
  },
  -- dimm code blocks
  {
    cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' },
    keys = {
      ['<leader>tt'] = { '<cmd>Twilight<CR>', { desc = 'toggle twilight' } },
    },
    'folke/twilight.nvim',
  },
}
