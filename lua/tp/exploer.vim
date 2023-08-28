let g:netrw_banner = 0 " remove banner
let g:netrw_liststyle = 3 " use treestyle for folders
let g:netrw_browse_split = 4 " open file in same window
let g:netrw_winsize = 20

function! OpenToRight()
  :normal v
  let g:path=expand('%:p')
  :q!
  execute 'belowright vnew' g:path
  :wincmd L
endfunction

function! OpenBelow()
  :normal v
  let g:path=expand('%:p')
  :q!
  execute 'belowright new' g:path
  :wincmd L
endfunction

function! NetrwMappings()
  noremap <buffer> <C-l> <C-W>l
  noremap <buffer> <C-f> :call ToggleNetrw()<cr>
  noremap <buffer> V :call OpenToRight()<cr>
  noremap <buffer> H :call OpenBelow()<cr>
endfunction

augroup netrw_mappings
  autocmd!
  autocmd filetype netrw call NetrwMappings()
augroup END


function! ToggleNetrw()
  if g:NetrwIsOpen
    let i = bufnr('$')
    while (i >= 1)
      if (getbufvar(i, '&filetype') ==# 'netrw')
        silent exe 'bwipeout ' . i
      endif
      let i -= 1
    endwhile
    let g:NetrwIsOpen = 0
  else
    let g:NetrwIsOpen = 1
    silent Lexplore
  endif
endfunction
