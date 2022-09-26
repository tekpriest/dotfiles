local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  vim.notify 'Installing packer close and reopen Neovim...'
end
vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

return packer.startup(function(use)
  -- plugin manager
  use 'wbthomason/packer.nvim'

  -- optimizer
  use { 'lewis6991/impatient.nvim' }

  -- essentials
  use 'nvim-lua/popup.nvim' -- an implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim' -- useful lua functions used ny lots of plugins
  use 'kyazdani42/nvim-web-devicons'
  use { 'windwp/nvim-autopairs' }
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {}
    end,
  }
  use 'nvim-lualine/lualine.nvim'

  -- auto session
  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {}
    end,
  }

  -- file explorer
  use { 'kyazdani42/nvim-tree.lua' }

  -- colorscheme
  use { 'rebelot/kanagawa.nvim' }
  use {
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup {
        theme_style = 'dark',
      }
    end,
  }
  use { 'svrana/neosolarized.nvim' }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'p00f/nvim-ts-rainbow' -- Parenthesis highlighting
  use 'windwp/nvim-ts-autotag' -- Autoclose tags
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/playground'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
  }

  -- git
  use 'lewis6991/gitsigns.nvim'
  use 'https://github.com/rhysd/conflict-marker.vim'

  -- cmp
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use { 'onsails/lspkind-nvim' } -- add vscode-like pictograms to neovim

  -- snippets
  use 'L3MON4D3/LuaSnip' --snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- lsp
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer' }

  -- eseential utils
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  }
  use { 'kdheepak/lazygit.nvim' }
  use 'editorconfig/editorconfig-vim'
  -- use 'karb94/neoscroll.nvim' -- smooth scroll

  -- lsp utils
  use 'antoinemadec/FixCursorHold.nvim' -- This is needed to fix lsp doc highlight
  use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
  use 'RRethy/vim-illuminate'
  use { 'tami5/lspsaga.nvim' }

  -- flutter
  use 'akinsho/flutter-tools.nvim'

  -- misc
  use { 'wakatime/vim-wakatime' } -- code time tracker
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = { 'kyazdani42/nvim-web-devicons' },
  } -- buffer tabs with super power
  use 'moll/vim-bbye'
  use 'akinsho/toggleterm.nvim'
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
  }
  use { 'stevearc/dressing.nvim' }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup {}
    end,
  }
  use { 'prettier/vim-prettier', run = 'yarn install && yarn add prettier-plugin-solidity', ft = { 'solidity' } }
  use { 'MunifTanjim/prettier.nvim' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use 'mfussenegger/nvim-dap'
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
  use 'folke/lua-dev.nvim'

  -- personal
  use '/Users/tp/Code/stackmap.nvim'
  -- use({
  -- 	"lewis6991/satellite.nvim",
  -- 	config = function()
  -- 		require("satellite").setup({})
  -- 	end,
  -- })
end)
