return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'terraform-ls',
        'json-lsp',
        'yaml-language-server',
        'docker-compose-language-service',
        'docker-language-server',
        'hadolint',
        'graphql-language-server-cli',
      },
      automatic_installation = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- require
      require 'custom.configs.lsp'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'bash',
        'dockerfile',
        'html',
        'json',
        'jsonc',
        'lua',
        'markdown',
        'markdown_inline',
        'query',
        'rust',
        'sql',
        'terraform',
        'toml',
        'yaml',
        'zig',
        'graphql',
        'cmake',
      },
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      return require 'custom.configs.null_ls'
    end,
  },
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    keys = {
      { '<leader>cs', '<cmd>SymbolsOutline<cr>', desc = 'Symbols Outline' },
    },
    config = true,
  },
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },
  {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      kind = 'split',
    },
    cmd = 'Neogit',
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'TodoTrouble', 'TodoTelescope', 'TodoQuickFix', 'TodoLocList' },
    config = function(_, opts)
      require('todo-comments').setup(opts)
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    event = 'VeryLazy',
    opts = {
      ignore_lsp = { 'lua_ls' },
      patterns = {
        '.git',
        '_darcs',
        '.hg',
        '.bzr',
        '.svn',
        'Makefile',
        'package.json',
        '=src',
      },
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    opts = function()
      require('telescope').load_extension 'projects'
    end,
  },
  { 'wakatime/vim-wakatime', event = 'InsertEnter' },
  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGitConfig' },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  { 'ellisonleao/glow.nvim', cmd = 'Glow',         ft = { 'markdown' } },
  {
    'ray-x/navigator.lua',
    dependencies = {
      { 'ray-x/guihua.lua',                 build = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    event = { 'BufRead' },
    opts = {
      mason = true,
      -- lsp = { disable_lsp = { 'tsserver' }, },
    },
    config = function(_, opts)
      require('navigator').setup(opts)
    end,
  },
  { 'ray-x/lsp_signature.nvim' },
  {
    'ray-x/aurora',
    lazy = false,
    config = function()
      vim.g.aurora_transparent = true
      vim.g.aurora_bold = true
      vim.g.aurora_italic = true
      vim.cmd [[colorscheme aurora]]
      vim.api.nvim_set_hl(0, 'Comment', { italic = true, fg = '#7F00AF' })
      vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bold = true })
      vim.api.nvim_set_hl(0, 'LspReferenceRead', { bold = true })
      vim.api.nvim_set_hl(0, 'LspReferenceText', { bold = true })
      vim.api.nvim_set_hl(0, '@field', { italic = true })
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      modw = 'virtualtext',
    },
    config = function(_, opts)
      require('colorizer').setup(opts)
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-null-ls').setup {
        automatic_setup = true,
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
}
