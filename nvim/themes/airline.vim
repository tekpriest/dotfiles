" enable tabline
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_section_a = airline#section#create(['branch'])
let g:airline_section_b = '%{strftime("%H:%M:%S")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline_section_z = '%{coc#status()}}'

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Switch to your current theme
let g:airline_theme = 'onedark'

" Always show tabs
set showtabline=2

" We don't need to see things like -- INSERT -- anymore
set noshowmode
let g:airline#extensions#coc#enabled = 1
