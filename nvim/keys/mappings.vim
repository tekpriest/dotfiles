let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

" Use alt + hjkl to resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>


" Telescope Remaps
nnoremap <C-p> :lua require('telescope.builtin').git_files()<Cr>
nnoremap <leader>tg :lua require('telescope.builtin').live_grep()<Cr>

nnoremap <leader>u :UndotreeToggle<CR>

" Hatred for escape key
inoremap jk <Esc>
inoremap kj <Esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" <TAB>: completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"Better tabbing
vnoremap < <gv
vnoremap > >gv

"Better window navigation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

nmap <silent> <Leader>h :nohlsearch<cr>
nmap <leader>Q :bufdo bdelete<cr>

" Allow gf to open non-existent files
map gf :edit :tabnew <cfile><cr>

" Maintain the cursor position when yanking a virtual selection
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lins, unless a count is
" provided
noremap <silent> <expr> j (v:count == 0 ? 'gj':'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk':'k')

" Open the current file in the default program (linux)
nmap <leader>x :!xdg-open %<cr><cr>

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Make Y behave like the other capitals
vnoremap Y y$

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ;; <Esc>A,<Esc>
