" ==============================================================================
" Filename: gfi.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

""
" @section Introduction, intro
" An improved version of the `gfi` mapping in Vim, which opens the file under the
" cursor, but now in a smarter way.

let s:save_cpo = &cpoptions
set cpoptions&vim

if exists('g:loaded_gfi')
  finish
endif
let g:loaded_gfi = 1

if !exists('g:gfi_open_file_command')
  ""
  " @setting(g:gfi_open_file_command)
  "
  " Allows the user to change the way how a file should open.
  let g:gfi_open_file_command = 'edit'
endif

""
" Go to the file under the cursor.
command! GFI :call gfi#goto_file()

nnoremap gf :GFI<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
