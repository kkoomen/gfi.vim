" ==============================================================================
" Filename: sort.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" @public
" A callback function used in `sort()` functions which sorts paths by directory
" followed by the remaining files.
function! gfi#sort#by_directory(path1, path2) abort
  return !isdirectory(a:path1) ? 1 : -1
endfunction

""
" @public
" A callback function used in `sort()` functions which sorts paths by files
" followed by the remaining directories.
function! gfi#sort#by_files(path1, path2) abort
  return isdirectory(a:path1) ? 1 : -1
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
