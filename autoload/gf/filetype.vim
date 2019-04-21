" ==============================================================================
" Filename: filetype.vim
" Maintainer: Kim Koomen <koomen@protonail.com>
" License: MIT
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

""
" Specific path lookups based on javascript-related filetypes.
" This function will take the following into account:
" - Search for a `moduleRoots` property in the package.json of the project and
"   try to find a match based on these paths. This will be used to resolve
"   absolute imports.
" - Check for an index.{ext} if the path is a directory, since
"   webpack-configured javascript projects mainly have imports where the
"   extension is ommitted and the import will automatically resolve `index`
"   files that are located in the imported directory.
function! gf#filetype#javascript(cfile) abort
  let l:buffer_git_root = gf#buffer#get_git_root()

  " Resolve files based on the 'moduleRoots' property in a package.json.
  let l:pkg_file = simplify(l:buffer_git_root . '/package.json')
  if filereadable(l:pkg_file)
    let l:pkg_contents = join(readfile(l:pkg_file), '')
    let l:json_dict = gf#parser#json#parse_string(l:pkg_contents)
    if has_key(l:json_dict, 'moduleRoots')
      for l:module_root in l:json_dict['moduleRoots']
        let l:path = simplify(l:buffer_git_root . '/' . l:module_root . '/' . a:cfile)

        " Javascript 'import' statements can be in a format such as:
        " `import Navigation from 'src/components/Navigation'`
        " where the 'Navigation' at the end of the import is the folder and will
        " automatically resolve the `index.(js|jsx)` file.
        if isdirectory(l:path)
          let l:index_file = gf#file#expand(simplify(l:path . '/index'))
          if gf#file#is_readable(l:index_file, 0)
            return l:index_file
          endif
        endif

        " If the directory/index pattern from above didn't return anything we
        " don't have an index in the directory. We'll continue to expand the
        " path and open any result.
        let l:expanded_path = gf#file#expand(l:path)
        if gf#file#is_readable(l:expanded_path, 1)
          return l:expanded_path
        endif
      endfor
    endif
  endif

  return 0
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
