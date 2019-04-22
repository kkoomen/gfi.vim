" ==============================================================================
" Filename: buffer.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" @public
" Open a new buffer with the given file. See @setting(g:gfi_open_file_command)
" for more info on how to change the way files/buffers open.
function! gfi#buffer#open(file) abort
  execute g:gfi_open_file_command . ' ' . a:file
endfunction

""
" @public
" Get the current buffer path relative to the git directory it is located in.
function! gfi#buffer#get_relative_git_path(...) abort
  return substitute(
        \ expand('%:p' . a:1),
        \ trim(system('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')),
        \ '',
        \ 'g'
        \ )
endfunction

""
" @public
" Get the git root based on the current buffer.
function! gfi#buffer#get_git_root() abort
  return trim(system('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel'))
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
