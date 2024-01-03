-- if true then return {} end
return {
  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'javascriptreact', 'typescriptreact' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      sync_install = false,
      auto_install = true,
      ensure_installed = {
        'lua',
        'json',
        'typescript',
        'javascript',
        'query',
        'regex',
        'sql',
        'html',
        'vim',
        'vimdoc',
        'yaml',
        'dart',
        'elixir',
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true, disable = { 'dart' } },
      autotag = { enabled = true },
      autopairs = { enabled = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- mappings for incremental selection (visual mappings)
          init_selection = '<CR>', -- maps in normal mode to init the node/scope selection
          node_incremental = 'grn', -- increment to the upper named parent
          scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
          node_decremental = 'grm', -- decrement to the previous node
        },
      },
      matchup = { enable = false },
      query_linter = { enable = true },
    },
    config = function(_, opts)
      if type(opts.ensure_installed == 'table') then
        -- @type table<string,boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  -- {
  --   'RRethy/vim-illuminate',
  --   event = 'VeryLazy',
  --   init = function()
  --     vim.cmd [[hi link IlluminatedWordText Visual ]]
  --     vim.cmd [[hi link IlluminatedWordRead Visual ]]
  --     vim.cmd [[hi link IlluminatedWordWrite Visual ]]
  --   end,
  -- },
}
