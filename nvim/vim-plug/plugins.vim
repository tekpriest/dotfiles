" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(data_dir . '/plugins')
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/whichkey.vim
source ~/.config/nvim/plugins/commentstring.vim
source ~/.config/nvim/plugins/dispatch.vim
source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/editorconfig.vim
source ~/.config/nvim/plugins/eunuch.vim
source ~/.config/nvim/plugins/exchange.vim
source ~/.config/nvim/plugins/firenvim.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/heritage.vim
source ~/.config/nvim/plugins/lastplace.vim
source ~/.config/nvim/plugins/lion.vim
source ~/.config/nvim/plugins/markdown-preview.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/pasta.vim


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
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'joshdick/onedark.vim'

  " Git Tooling
  Plug 'tpope/vim-fugitive'                            " Run `:git` commands
  Plug 'tpope/vim-rhubarb'                             " :GBrowse to open files in GitHub
  Plug 'junegunn/gv.vim'                               " Git commit browser
  Plug 'mhinz/vim-signify'                             " Sign Columns

  " -- LUA PLUGINS --
" Recommended > updating the parsers on update
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
  Plug 'nvim-treesitter/playground'   

  Plug 'kyazdani42/nvim-web-devicons'                 " Devicons for vim
  Plug 'hrsh7th/nvim-compe'                           " Autocompletetion Plugin For Neovim
  Plug 'romgrk/barbar.nvim'                           " Tabs for Vim
  Plug 'norcalli/nvim-colorizer.lua'                  " Colorizer for Vim
  Plug 'windwp/nvim-autopairs'                        " Auto close parenthesis, brackets etc
  Plug 'TimUntersberger/neogit'                       " Git Integration for Neovim

  " Telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

call plug#end()
