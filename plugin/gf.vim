" ==============================================================================
" Filename: gf.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

if exists('g:loaded_gf')
  finish
endif
let g:loaded_gf = 1

if !exists('g:gf_open_file_command')
  let g:gf_open_file_command= 'edit'
endif

nmap gf :call gf#open_file()<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
