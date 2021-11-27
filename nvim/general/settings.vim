" set leader key
let g:mapleader = "\<Space>"

syntax enable
set hidden
set nowrap
set encoding=utf-8
set pumheight=10
set fileencoding=utf-8
set ruler
set cmdheight=2
set iskeyword+=-
set mouse=a
set splitbelow
set splitright
set t_Co=256
set conceallevel=0
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set autoindent
set laststatus=2
set number
set cursorline
set background=dark
set showtabline=2
set noshowmode
set nobackup
set nowritebackup
set updatetime=300
set redrawtime=10000
set timeoutlen=500
set formatoptions-=cro
set clipboard=unnamedplus
set autochdir
set relativenumber
set smartcase
set noswapfile
set undofile
set scrolloff=2
set sidescrolloff=8
set lcs=tab:▸\ ,trail:·
set title
set signcolumn=yes:2
set termguicolors
set spell
set ignorecase
set list
set nojoinspaces
set exrc

au! BufWritePost $MYVIMRC source %

cmap w!! %!sudo tee > /dev/null %


filetype plugin on " Auto Indentation Levels
filetype indent off " Auto Indentation Levels

