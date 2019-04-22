" ==============================================================================
" Filename: go.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" Go has an 'import' syntax which contains paths relative to the $GOPATH var.
" For example:
"   import (
"      'github.com/username/repo'
"      'github.com/username/repo/src/dir/subdir'
"   )
" These paths can be resolved via '$GOPATH/src/<import>'.
function! gfi#filetype#go#goto_file(cfile) abort
  let l:gopath = expand('$GOPATH')
  if l:gopath !=# '$GOPATH'
    let l:path = simplify(l:gopath . '/src/' . a:cfile)
    if gfi#file#is_readable(l:path, 1)
      return l:path
    endif
  endif

  return 0
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
