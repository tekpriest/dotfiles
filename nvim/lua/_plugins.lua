local disabled_built_ins = {
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  ----------------
  --  Required  --
  ----------------
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'lewis6991/impatient.nvim' }, -- Optimiser
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        dimInactive = true,
        globalStatus = true,
      }
      vim.cmd 'colorscheme kanagawa'
    end,
  },
  { 'kyazdani42/nvim-web-devicons', lazy = true, config = true },
  { 'stevearc/dressing.nvim', event = 'VeryLazy' },
  { 'rmagatti/auto-session', config = true },
  {
    'andymass/vim-matchup',
    event = 'BufRead',
    init = function()
      vim.g.matchup_override_vimtex = 1
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = {
        method = 'popup',
      }
    end,
  },
  { 'tpope/vim-fugitive', cmd = 'G' },
  { 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' } },
  -- {
  --   'NvChad/nvim-colorizer.lua',
  --   -- event = { 'BufReadPost', 'BufNewFile' },
  --   config = function()
  --     require('colorizer').setup {
  --       user_default_options = {
  --         RRGGBBAA = true, -- #RRGGBBAA hex codes
  --         AARRGGBB = true, -- 0xAARRGGBB hex codes
  --         css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --         css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  --         mode = 'virtualtext', -- Set the display mode.
  --         -- Available methods are false / true / "normal" / "lsp" / "both"
  --         -- True is same as normal
  --         tailwind = true, -- Enable tailwind colors
  --         -- parsers can contain values used in |user_default_options|
  --         sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
  --         virtualtext = '■',
  --       },
  --     }
  --   end,
  -- },
  {
    'numToStr/Comment.nvim',
    event = 'BufReadPost',
    keys = {
      { mode = 'n', 'gc' },
      { mode = 'n', 'gb' },
      { mode = 'x', 'gc' },
      { mode = 'x', 'gb' },
    },
    config = true,
  },
  'tpope/vim-repeat',
  {
    'kyazdani42/nvim-tree.lua',
    init = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function(args)
          if vim.fn.isdirectory(args.match) == 1 then
            require('lazy').load { plugins = 'nvim-tree.lua' }
            return true
          end
        end,
      })
    end,
    config = function()
      require 'plugins.nvimtree'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    -- event = "BufRead",
    cmd = { 'TSInstall', 'TSUpdate' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',

      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('treesitter-context').setup()
          vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'Folded' })
        end,
      },
    },
    config = function()
      require 'plugins.treesitter'
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    config = function()
      require 'plugins.indentblankline'
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    cmd = 'Telescope',
    dependencies = {
      {
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = { 'tami5/sqlite.lua' },
      },
      {
        'nvim-telescope/telescope-file-browser.nvim',
      },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-dap.nvim',
      'nvim-telescope/telescope-project.nvim',
      'kdheepak/lazygit.nvim',
      {
        'ahmedkhalf/project.nvim',
        config = function()
          require 'project_nvim'
        end,
      },
      'cljoly/telescope-repo.nvim',
    },
    config = function()
      require 'plugins.telescope'
      -- load extensions
      require('telescope').load_extension 'file_browser'
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'frecency'
      require('telescope').load_extension 'project'
      require('telescope').load_extension 'lazygit'
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    config = function()
      require 'plugins.gitsigns'
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require 'plugins.autopairs'
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    keys = '<leader>x',
    config = function()
      require 'plugins.trouble'
    end,
  },
  --------------------------------------------
  -- LSP, Diagnostics, Snippets, Completion --
  --------------------------------------------

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'smjonas/inc-rename.nvim', config = true },
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      { 'folke/neodev.nvim', config = true },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      require 'lsp.setup'
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require 'lsp.null-ls'
    end,
  },
  {
    'onsails/lspkind-nvim',
    lazy = true,
    config = function()
      require('lspkind').init {
        mode = 'symbol_text',
        preset = 'codicons',
      }
    end,
  },

  {
    'SmiteshP/nvim-navic',
    event = 'BufReadPost',
    config = function()
      require('nvim-navic').setup {
        -- icons = require("lspkind").symbol_map,
        separator = '',
      }
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp', -- required by lsp/init.lua
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      --{ "dmitmel/cmp-cmdline-history", },
      'kdheepak/cmp-latex-symbols',
      {
        'saadparwaiz1/cmp_luasnip',
        'quangnguyen30192/cmp-nvim-ultisnips',
        dependencies = {
          { 'L3MON4D3/LuaSnip', tag = 'v<CurrentMajor>.*' },
          --[[ {
            'SirVer/ultisnips',
            dependencies = 'honza/vim-snippets',
            init = function()
              vim.opt.rtp:append { vim.fn.stdpath 'data' .. '/site/pack/packer/start/vim-snippets' }
              vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
              vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
              vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
              vim.g.UltiSnipsListSnippets = '<Plug>(utlisnips_list_snippets)'
              vim.g.UltiSnipsRemoveSelectModeMappings = 0
            end,
          }, ]]
        },
      },
    },
    config = function()
      require 'plugins.cmp'
    end,
  },
  { 'chrisbra/csv.vim', ft = 'csv' },
  {
    'jose-elias-alvarez/typescript.nvim',
    config = function()
      require 'plugins.typescript'
    end,
  },
  'b0o/schemastore.nvim',
  {
    'akinsho/toggleterm.nvim',
    lazy = false,
    config = function()
      require 'plugins.toggleterm'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'plugins.lualine'
    end,
  },
  {
    'ray-x/go.nvim',
    ft = 'go',
    lazy = true,
    dependencies = { 'ray-x/guihua.lua' },
  },
  {
    'j-hui/fidget.nvim',
    config = true,
  },
}, { install = { colorscheme = { 'kanagawa' } } })
