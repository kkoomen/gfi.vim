" ==============================================================================
" Filename: gfi.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" @public
" This is the main function that will add default behavior for resolving paths
" and runs filetype specific logic when it can.
function! gfi#goto_file() abort
  let l:cfile = expand('<cfile>')
  if empty(l:cfile)
    return 0
  endif

  echo 'Opening "' . l:cfile . '"...'

  " All the default paths that should be looked for, no matter the filetype,
  " will be stored in this variable.
  let l:paths = []

  " Check for files relative to the current buffer.
  call add(l:paths, simplify(expand('%:p:h') . '/' . l:cfile))

  " Check for a file relative to the current working directory of vim.
  call add(l:paths, simplify(getcwd() . '/' . l:cfile))

  " Check for a file relative to its git root directory where 'cfile' can be:
  " - src/path/to/a/filename
  " - src/path/to/a/filename.{ext}
  " We're looking for a format here of <git-root>/<cfile>.
  call add(l:paths, simplify(gfi#buffer#get_git_root() . '/' . l:cfile))

  for l:path in l:paths
    let l:expanded_path = gfi#file#expand(l:path, 0)
    if l:expanded_path == -1
      return -1
    elseif gfi#file#is_readable(l:expanded_path, 0)
      return gfi#buffer#open(l:expanded_path)
    endif
  endfor

  " Check filetype specific.
  let l:filetypes = {
        \ 'javascript': '^\(javascript.jsx\|typescript.tsx\|jsx\|javascript\|typescript\)$',
        \ 'go': '^go$',
        \ }
  for [l:ft, l:regex] in items(l:filetypes)
    if &filetype =~# l:regex
      let l:ft_resolved_file =
            \ call('gfi#filetype#' . l:ft . '#goto_file', [ l:cfile ])

      if gfi#file#is_readable(l:ft_resolved_file, 1)
        return gfi#buffer#open(l:ft_resolved_file)
      endif
    endif
  endfor

  for l:path in l:paths
    let l:expanded_path = gfi#file#expand(l:path, 1)
    if l:expanded_path == -1
      return -1
    elseif gfi#file#is_readable(l:expanded_path, 1)
      return gfi#buffer#open(l:expanded_path)
    endif
  endfor

  echo 'Could not open "' . l:cfile . '"'
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
