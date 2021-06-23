" Auto Install VIM Plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " autocmd VimEnter * PlugInstall
  " autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

  Plug 'scrooloose/NERDTree' " File Explorer
  Plug 'itchyny/lightline.vim' " Statusline
  Plug 'suan/vim-instant-markdown', {'rtp': 'after'}  " Markdown Preview
  Plug 'frazrepo/vim-rainbow' " Rainbow brackets
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " Highlighting Nerdtree
  Plug 'jreybert/vimagit'                             " Magit-like plugin for vim
  Plug 'tpope/vim-surround'                           " Change surrounding marks
  Plug 'PotatoesMaster/i3-vim-syntax'                 " i3 config highlighting
  Plug 'ap/vim-css-color'                             " Color previews for CSS
  Plug 'junegunn/goyo.vim'                            " Distraction-free viewing
  Plug 'junegunn/limelight.vim'                       " Hyperfocus on a range
  Plug 'junegunn/vim-emoji'                           " Vim needs emojis!
  Plug 'sheerun/vim-polyglot'                         " Better syntax suport
  Plug 'liuchengxu/vim-which-key'                     " Show available shortcuts
  Plug 'mbbill/undotree'                              " Undo logs
  Plug 'airblade/vim-rooter'                          " Auto change to root firectory
  Plug 'airblade/vim-gitgutter'                       " Show git diff in the sign column
  Plug 'airblade/vim-matchquote'                      " Match quote
  Plug 'tpope/vim-unimpaired'                         " Makes it possible to use []
  Plug 'tpope/vim-endwise'                            " Add end to ruby statements
  Plug 'rhysd/git-messenger.vim'                      " Git messenger
  Plug 'rhysd/conflict-marker.vim'                    " Git conflict marker
  Plug 'KeitaNakamura/neodark.vim'                    " Onedark theme
  Plug 'jeetsukumaran/vim-indentwise'
  Plug 'tommcdo/vim-lion'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'Yggdroot/indentLine'
  Plug 'tpope/vim-haml'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-markdown'
  Plug 'grantlucas/nginx-vim'
  Plug 'tpope/vim-rails'
  Plug 'vim-ruby/vim-ruby'
  Plug 'sunaku/vim-ruby-minitest'
  Plug 'slim-template/vim-slim'
  Plug 'pechorin/any-jump.vim'
  Plug 'wincent/terminus'
  Plug 'tpope/vim-characterize'
  Plug 'tpope/vim-commentary'
  Plug 'lfv89/vim-interestingwords'
  Plug 'RRethy/vim-illuminate'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'wellle/visual-split.vim'

  " Ruby
  Plug 'janko/vim-test'

  " Unix
  Plug 'tpope/vim-eunuch'
  Plug 'jez/vim-superman'

  Plug 'justinmk/vim-dirvish'
  Plug 'wsdjeg/vim-fetch'
  Plug 'junegunn/fzf.vim'

  Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}



call plug#end()
