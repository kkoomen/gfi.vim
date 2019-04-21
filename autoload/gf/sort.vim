" ==============================================================================
" Filename: sort.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" A callback function used in `sort()` functions which sorts paths by directory.
function! gf#sort#by_directory(path1, path2) abort
  return !isdirectory(a:path1) ? 1 : -1
endfunction

" A callback function used in `sort()` functions which sorts paths by files.
function! gf#sort#by_files(path1, path2) abort
  return isdirectory(a:path1) ? 1 : -1
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
