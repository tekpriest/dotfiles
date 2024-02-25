" Plugin Name: Applescript
" Author: mityu
" Modified: techpriest
" Last Change: 24-Feb-2024

let s:cpo_save=&cpo
set cpo&vim

au BufNewFile,BufRead *.scpt setf applescript
au BufNewFile,BufRead *.applescript setf applescript
au BufNewFile,BufRead * call s:checkshebang()

function s:checkshebang()
  if !did_filetype() && getline(1) =~ '^#!.osascript$'
    setfiletype applescript
  endif
endfunction

let &cpo=s:cpo_save
unlet s:cpo_save

" vim: foldmethod=marker
