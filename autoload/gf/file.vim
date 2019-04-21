" ==============================================================================
" Filename: file.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" Create a prompt towards the user with 2 or more paths as an input. The paths
" can be regular files or directories. The one being selected will be returned.
" A user may enter '0' to cancel the prompt.
" This function won't be called if the `paths` argument has less than 2 paths.
function! gf#file#prompt_multiple(paths) abort
  echo 'Multiple matches found'
  echo '[0] Cancel'
  for l:path in a:paths
    if isdirectory(l:path)
      echo '[' . (index(a:paths, l:path) + 1) . '] ' . l:path . ' (directory)'
    else
      echo '[' . (index(a:paths, l:path) + 1) . '] ' . l:path
    endif
  endfor

  " Grab the user input, validate it and grab the selected filepath.
  let l:selected_index = input('Enter an index to open: ')

  " input() does not add a new line after the input has been given, so upcoming
  " messages will be immediately next to the input. To prevent this we insert a
  " newline character.
  echo "\n"

  if l:selected_index !~# '^\d\+$'
    echoerr 'Input must be an integer'
  elseif l:selected_index ==# '0'
    return 0
  else
    let l:idx = l:selected_index - 1
    let l:selected_filepath = get(a:paths, l:idx)
    if empty(l:selected_filepath)
      echoerr 'Index does not exist'
    else
      return l:selected_filepath
    endif
  endif
endfunction

""
" Check for a file './filename' with or without out extension and expand it.
" - If a single file is found, we return its path.
" - If multiple matches are found with different extensions or directories that
"   have the same name, we prompt the user with them and open the one they
"   selected.
function! gf#file#expand(expand_expr) abort
  " Check for files only (TODO: support dirs).
  let l:files = sort(expand(a:expand_expr . '*', 0, 1), 'gf#sort#by_files')

  if len(l:files) == 0
    " Nothing found.
    return 0
  elseif len(l:files) == 1
    " Found exactly 1 match.
    return get(l:files, 0)
  else
    " Prompt the user which match should be opened.
    return gf#file#prompt_multiple(l:files)
  endif
endfunction

""
" Check whether a certain filepath is a readable file or an existing directory.
function! gf#file#is_readable(filepath, include_directories) abort
  if a:include_directories == 1
    return filereadable(a:filepath) || isdirectory(a:filepath)
  else
    return filereadable(a:filepath)
  endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
