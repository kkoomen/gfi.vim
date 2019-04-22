" ==============================================================================
" Filename: gf.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" This is the main function that will add default behavior for resolving paths
" and runs filetype specific logic when it can.
function! gf#goto_file() abort
  let l:cfile = expand('<cfile>')
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
  call add(l:paths, simplify(gf#buffer#get_git_root() . '/' . l:cfile))

  for l:path in l:paths
    let l:expanded_path = gf#file#expand(l:path)
    if gf#file#is_readable(l:expanded_path, 1)
      return gf#buffer#open(l:expanded_path)
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
            \ call('gf#filetype#' . l:ft . '#goto_file', [ l:cfile ])

      if gf#file#is_readable(l:ft_resolved_file, 1)
        return gf#buffer#open(l:ft_resolved_file)
      endif
    endif
  endfor

  echo 'Could not open "' . l:cfile . '"'
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
