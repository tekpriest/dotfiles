call plug#begin('~/.config/nvim/autoload/plugged')
  Plug 'neoclide/coc.nvim', {'branch':'release'}       " VSCode like features
  Plug 'liuchengxu/vim-which-key'                     " Show available shortcuts
  Plug 'mbbill/undotree'                              " Undo logs
  Plug 'airblade/vim-rooter'                          " Open projects in root directory
  Plug 'ryanoasis/vim-devicons'                       " Devicons
  Plug 'justinmk/vim-sneak'                           " Use `s` to navigate faster 
  Plug 'AndrewRadev/tagalong.vim'                     " Auto close&rename HTML tags
  Plug 'unblevable/quick-scope'                       " Faster `f` movement
  Plug 'voldikss/vim-floaterm'
  Plug 'mhinz/vim-startify'                           " Better Starting screen for Vim
  Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}     " Navigate Linux Filesystem
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'alvan/vim-closetag'
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-commentary'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'joshdick/onedark.vim'
  Plug 'kosayoda/nvim-lightbulb'                   " VSCode like Light Bulb
  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'} " Vim Bottom Line
  Plug 'kyazdani42/nvim-tree.lua'                     " Explorer for Vim

  " Git Tooling
  Plug 'tpope/vim-fugitive'                            " Run `:git` commands
  Plug 'tpope/vim-rhubarb'                             " :GBrowse to open files in GitHub
  Plug 'junegunn/gv.vim'                               " Git commit browser
  Plug 'mhinz/vim-signify'                             " Sign Columns

  " -- LUA PLUGINS --
" Recommended > updating the parsers on update
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
  Plug 'nvim-treesitter/playground'   

  Plug 'neovim/nvim-lspconfig'                        " Native Neovim Language Server Protocol
  Plug 'glepnir/lspsaga.nvim'                         " Code actions and other UI LSP features
  Plug 'kyazdani42/nvim-web-devicons'                 " Devicons for vim
  Plug 'hrsh7th/nvim-compe'                           " Autocompletetion Plugin For Neovim
  Plug 'anott03/nvim-lspinstall'                      " Easily Install Language Server Protocols
  Plug 'kyazdani42/nvim-tree.lua'                     " Explorer for Vim
  Plug 'romgrk/barbar.nvim'                           " Tabs for Vim
  Plug 'kosayoda/nvim-lightbulb'                      " VSCode like Light Bulb
  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'} " Vim Bottom Line
  Plug 'norcalli/nvim-colorizer.lua'                  " Colorizer for Vim
  Plug 'p00f/nvim-ts-rainbow'                         " Bracket Pair Colorizer
  Plug 'b3nj5m1n/kommentary'                          " Comment Things Faster 
  Plug 'windwp/nvim-autopairs'                        " Auto close parenthesis, brackets etc
  Plug 'TimUntersberger/neogit'                       " Git Integration for Neovim

  " Telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

call plug#end()
