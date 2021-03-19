" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

  " Better Syntax Support
  Plug 'sheerun/vim-polyglot'
  " File Explorer
  Plug 'scrooloose/NERDTree'
  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'
  " One Dark theme
  Plug 'joshdick/onedark.vim'
  " Stable version of coc
  Plug 'neoclide/coc.nvim', {'branch':'release'}
  " Keep up to date with master
  " Plug 'neoclide/coc.nvim', {'do': 'yarn install --froze-lockfile'}
  " Markdown Preview
  Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'kevinhwang91/rnvimr', {'do':'make sync'}
  Plug 'junegunn/fzf', {'do':{-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'tpope/vim-commentary'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'unblevable/quick-scope'
  Plug 'justinmk/vim-sneak'
  Plug 'metakirby5/codi.vim'
  Plug 'honza/vim-snippets'
  Plug 'voldikss/vim-floaterm'
  Plug 'liuchengxu/vim-which-key'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'mhinz/vim-startify'
  Plug 'ChristianChiarulli/far.vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'

call plug#end()
