local fmt = string.format
local fn = vim.fn
local paq_dir = fmt('%s/site/pack/paqs/start/paq-nvim', fn.stdpath('data'))

if fn.empty(fn.glob(paq_dir)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', paq_dir})
end

require 'paq' {
  -- Colorschemes
  'sainnhe/gruvbox-material',
  'savq/melange',
  'rktjmp/lush.nvim',

  -- Package Manager
  'savq/paq-nvim',

  'kana/vim-smartinput', -- auto close delimiters
  'airblade/vim-rooter',

  -- Treesitter
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/playground',

  -- Markup
  'lervag/VimTeX',
  'lervag/wiki.vim',
  'gabrielelana/vim-markdown',
  {'mattn/emmet-vim',opt=true},

  -- Snippets
  'sirver/ultisnips',
  'honza/vim-snippets',

  -- Core
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  {'kyazdani42/nvim-web-devicons', opt=true},

  -- Telescope
  'nvim-telescope/telescope.nvim',

  -- LSP & Language Support
  'williamboman/nvim-lsp-installer',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-compe',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',
  'L3MON4D3/LuaSnip',

  -- Javascript
  'pangloss/vim-javascript',
  'HerringtonDarkholme/yats.vim',

  -- Misc
  'SmiteshP/nvim-gps',
  'ojroques/nvim-lspfuzzy',
  'nvim-lualine/lualine.nvim',
  'rcarriga/nvim-notify',
  'kyazdani42/nvim-tree.lua',
  {'folke/which-key.nvim', run = function() require('config.which-key') end},
  {'folke/persistence.nvim', run = function() require('persistence').setup() end};
  {'norcalli/nvim-colorizer.lua', as='colorizer',opt=true};
  {'mechatroner/rainbow_csv', opt=true};
  {'lukas-reineke/indent-blankline.nvim', opt=true};

}:setup({verbose=false}):sync()

