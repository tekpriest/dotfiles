" set leader key
let g:maplaeader = "\<Space>"

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
set splitbelow splitright
set t_Co=256
set conceallevel=0
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set smartindent
set autoindent
set number relativenumber
set nu
set smartcase
set noswapfile
set undofile
set cursorline
set background=dark
set showtabline=2
set laststatus=2
set noshowmode
set nobackup " Adviced by COC
set nowritebackup " Adviced by COC
set updatetime=100
set timeoutlen=500
set formatoptions-=cro
set clipboard=unnamedplus
set path+=**
set wildmenu
set wildignorecase
set wildmode=list:longest,full
set wildignore+=tags,cscope.*
set wildignore+=*/min/*
set wildignore+=*/.git/**/*
set wildignore+=*/node_modules/**/*
set wildignore+=*/tmp/**/*
set incsearch
set fillchars+=vert:\ " Remove the pipes | that act as separators on splits
let g:rehash256=1
set nocompatible
set complete-=i  " Don't look in included files.
set completeopt=menu
set nrformats-=octal
set signcolumn=yes
set hlsearch
set wrap
set breakindent
set breakindentopt=sbr
set fillchars+=stl:\ ,stlnc:\ 
" Unicode curly arrow, space
set showbreak=↪> 
set scrolloff=3
set display+=lastline
set title
set shortmess=atIc
set noequalalways
set autoread
set notimeout
set ttimeout
set tags=.git/tags,tags
" Project-specific vimrc
set exrc
set secure

if !has('nvim')
  " Avoid delay with O immediately after Esc.
  " http://stackoverflow.com/a/2158610/151007
  set noesckeys
endif

if has('nvim')
  autocmd VimLeave * set titleold=:)
endif

filetype off
filetype plugin indent on

au! BufWritePost $MYVIMRC source %
cmap w!! w !sudo tee %


" Fix sizing issue with alacritty
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

" Support for org files
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org call org#SetOrgFileType()

" Menu bar
set guioptions-=m " Remove menu bar
set guioptions-=T " remove toolbar
set guioptions-=r " Remove right-hand scroll bar
set guioptions-=L " remove left-hand scroll bar
set guifont=FiraCode\ Nerd\ Font:h15

" Show tabs and trailing whitespace visually.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif
autocmd InsertEnter * set nolist
autocmd InsertLeave * set list

" gm jumps to middle of current screen line's text.
"
" (Middle of entire line is easier: virtcol('$')/2)
function! GotoMiddle()
  " Get buffer width. (http://stackoverflow.com/a/26318602/151007)
  redir => signlist
    execute "silent sign place buffer=".bufnr('')
  redir end
  let signlist = split(signlist, '\n')
  let width = winwidth(0) - &numberwidth - &foldcolumn - (len(signlist) > 2 ? 2 : 0)

  normal g^
  let first_non_blank_char = col('.') % width
  normal g$
  let last_non_blank_char = 1 + ((col('.')-1) % width)
  let middle_non_blank_char = first_non_blank_char + (last_non_blank_char - first_non_blank_char) / 2
  execute "normal g0".middle_non_blank_char."l"
endfunction
nnoremap <silent> gm :call GotoMiddle()<CR>

" <Leader><space> turns off search highlighting and enable CSS highlighting.
if exists("*css_color#enable()")
  nnoremap <Leader><space> :call css_color#enable()<CR>:nohlsearch<CR>
else
  nnoremap <Leader><space> :nohlsearch<CR>
endif

" Hide CSS highlight when searching so search highlight is visible
if exists("*css_color#disable()")
  nnoremap / :call css_color#disable()<CR>/
endif

" Make Y consistent with D and C (instead of yy)
nnoremap Y y$

" Visually select the text that was most recently edited/pasted.
" Note: gv selects previously selected area.
nmap gV `[v`]

" Retain cursor position when visually yanking.
xnoremap <expr> y 'my"'.v:register.'y`y'
xnoremap <expr> Y 'my"'.v:register.'Y`y'

" Backspace closes buffer.
nnoremap <BS> :bdelete<CR>

" Prevent Vim from scrolling original window when splitting horizontally.
" See example 'Restoring the View' in Vim manual chapter 41.10.
nnoremap <C-W>s Hmx``:split<CR>`xzt``

" Save all buffers when focus lost, ignoring warnings,
" and return to normal mode.
"
" Ideally we'd have:
"
"   autocmd FocusLost * silent! wa stopinsert
"
" but stopinsert doesn't seem to work inside a FocusLost autocommand.
" So we use a long-winded approach instead.
"
" http://tech.groups.yahoo.com/group/vim/message/94986
autocmd FocusLost * nested silent! wa
autocmd FocusLost * if mode()[0] =~ 'i\|R' | call feedkeys("\<Esc>") | endif

" Wipe all hidden buffers.
command! Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  let visible = []
  for i in range(1, tabpagenr('$'))
    call extend(visible, tabpagebuflist(i))
  endfor
  for b in filter(range(1, bufnr('$')), {_,b -> bufloaded(b) && index(visible,b) == -1})
    execute 'bw' b
  endfor
endfunction


"
" Filetypes
"

au FileType css setlocal iskeyword+=-
au FileType ruby setlocal iskeyword+=_
au BufEnter *.js syn match ErrorMsg /console.log/
au FileType coffee syn match ErrorMsg /console.log/
au FileType ruby syn match ErrorMsg /puts/
au Filetype eruby.yaml,yaml,yml setlocal commentstring=#\ %s

au FileType javascript nnoremap <buffer> <leader>L iconsole.log()<Esc>
au FileType javascript inoremap <buffer> <leader>L console.log()<Left>
au FileType ruby nnoremap <buffer> <leader>L iRails.logger.info("[aws]" )<Esc>
au FileType ruby inoremap <buffer> <leader>L Rails.logger.info("[aws] ")<Left><Left>

" syntax checker
nnoremap <Leader>s :w \| !sinter %<CR>

function! s:indentation(inner)
  let indent = indent(line('.'))

  if indent == 0
    if !empty(getline('.'))
      return
    endif

    let line = line('.')
    while empty(getline(line))
      normal! j
      let line += 1
    endwhile
    return s:indentation(a:inner)
  endif

  let first_line = search('\v^\s{,'.(indent-1).'}\S', 'nWb') + 1
  let last_line  = search('\v^\s{,'.(indent-1).'}\S', 'nW')  - 1

  if a:inner
    while empty(getline(first_line))
      let first_line += 1
    endwhile

    while empty(getline(last_line))
      let last_line -= 1
    endwhile
  endif

  " line-wise
  execute 'normal! '.first_line.'GV'.last_line.'G'
endfunction

xnoremap <silent> ii :<c-u>call <sid>indentation(1)<cr>
onoremap <silent> ii :<c-u>call <sid>indentation(1)<cr>
xnoremap <silent> ai :<c-u>call <sid>indentation(0)<cr>
onoremap <silent> ai :<c-u>call <sid>indentation(0)<cr>

" Disable unwanted built-in plugins.
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_netrwPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

" Helpful.vim
let g:helpful=1


" Any Jump
let g:any_jump_results_ui_style = 'filename_last'
let g:any_jump_grouping_enabled = 1

" BufExplorer configuration
"nmap <expr> <script> <silent> <unique> <CR> &buftype ==? '' ? ':BufExplorer<CR>' : '<CR>'
"let g:bufExplorerDefaultHelp=0
"let g:bufExplorerDisableDefaultKeyMapping=1
"let g:bufExplorerShowRelativePath=1
"let g:bufExplorerShowDirectories=0
"let g:bufExplorerShowNoName=1

" vim-gitgutter
xmap ghs <Plug>(GitGutterStageHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" vim-rooter
let g:rooter_patterns = ['.git', '.root']
let g:rooter_change_directory_for_non_project_files = 'current'

" vim-surround
" Add replacement on # for ruby string interplation.
let g:surround_35 = "#{\r}"

" vim-projectionist
let g:projectionist_heuristics = {
  \   "Gemfile&config/application.rb": {
  \     "app/models/*.rb": {
  \       "template": ["class {camelcase|capitalize} < ApplicationRecord", "end"]
  \     },
  \     "app/controllers/*.rb": {
  \       "template": ["class {camelcase|capitalize} < ApplicationController", "end"],
  \     },
  \     "app/jobs/*.rb": {
  \       "template": ["class {camelcase|capitalize} < ApplicationJob", "end"],
  \       "type": "presenter"
  \     },
  \     "app/presenters/*_presenter.rb": {
  \       "template": ["class {camelcase|capitalize}", "end"],
  \       "type": "presenter"
  \     },
  \     "app/frontend/styles/*.sass": {
  \       "type": "sass"
  \     },
  \     "app/frontend/javascripts/controllers/*_controller.js": {
  \       "type": "stimulus",
  \       "template": [
  \         "import {open} Controller {close} from 'stimulus'",
  \         "",
  \         "export default class extends Controller {",
  \         "",
  \         "  static targets = []",
  \         "",
  \         "}"]
  \     },
  \     "config/*": {
  \       "type": "config"
  \     },
  \   },
  \   "plugin/": {
  \     "plugin/*.vim": {
  \       "type": "plugin"
  \     },
  \     "autoload/*.vim": {
  \       "type": "autoload"
  \     },
  \     "doc/*.text": {
  \       "type": "doc"
  \     },
  \   }
  \ }

" vim-dirvish
" sort directories before files, alphabetical
let g:dirvish_mode = ':sort /^.*[\/]/'  " from dirvish faq
augroup my_dirvish_events
  autocmd!

  " Map `gh` to hide dotfiles.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer> gh :silent :keeppatterns g@\v/\.[^\/]+/?$@d<cr>

  autocmd FileType dirvish nnoremap <buffer> + :edit %
augroup END

" vim-illuminate
let g:Illuminate_highlightUnderCursor = 0
let g:Illuminate_delay = 5000


" indentLine
let g:indentLine_char = '⋮'  " ¦
let g:indentLine_fileType = ['slim', 'sass', 'yml', 'erb']
let g:indentLine_setColors = 0
highlight! link Conceal EndOfBuffer

" Create directories as needed when writing files.
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

let g:dash_scopes = {
      \ 'ruby': 'r',
      \ 'javascript': 'js',
      \ 'css': 'css',
      \ }
command! Dash call SearchDash(g:dash_scopes[&filetype])
function SearchDash(scope)
  let url = 'dash://'.a:scope.':'.expand('<cword>')
  call system('open '.url)
endfunction

" vim-test
nmap <silent> <Leader>tt :wa\|:TestNearest<CR>
nmap <silent> <Leader>tf :wa\|:TestFile<CR>
let test#strategy = 'iterm'  " basic | vimterminal
let g:test#preserve_screen = 1

" fzf.vim
set rtp+=/usr/local/opt/fzf
map <leader>f :Files<CR>
let g:fzf_preview_window = ''
let g:fzf_layout = { 'window': {
                \ 'width': 0.5,
                \ 'height': 0.1,
                \ 'highlight': 'Comment',
                \ 'border': 'sharp' } }

" git-messenger
let g:git_messenger_preview_mods = 'botright'
" Stop the preview window closing immediately (unexplained interaction with vim-gitgutter):
" https://github.com/rhysd/git-messenger.vim/issues/54
let g:git_messenger_close_on_cursor_moved = v:false
