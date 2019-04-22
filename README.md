# gfi.vim

A zero-configuration extension and improved version of the `gf` command in Vim,
which opens the file under the cursor, but now in a smarter way.

# Table of Contents
- [gfi.vim](#gfivim)
- [Table of Contents](#table-of-contents)
- [How It Works](#how-it-works)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
  * [`g:gfi_open_file_command`](#ggfi_open_file_command)
- [Contributing](#contributing)
  * [Linting](#linting)
  * [Documentation](#documentation)

# How It Works

Files will be resolved now based on its path:<br />
- relative to the current buffer
- relative to vim's current working directory
- based on the git directory it is located in (to resolve absolute imports)

This is default behavior for every filetype.

<hr />

Files will also be checked in a more advanced way per filetype when it can:

- javascript / typescript / jsx

    Most javascript projects these days use webpack to resolve their
    import statements. This module is also able to resolve these import paths,
    relative or absolute. Javascript-like filetype buffers will also try to
    resolve paths based on:

    - The `moduleRoots` property in the `package.json` of the project.
    - Whether the input is a directory and if it is, it will look for an `index`
      file in that directory, since webpack is resolving `index` files if a
      directory is imported.

- golang

    Go has an `import` syntax which contains paths relative to the `$GOPATH` var.<br />
    For example:<br />
    ```
    import (
        "github.com/username/repo"
        "github.com/username/repo/src/dir/subdir"
    )
    ```
    These paths will be resolved using the format `$GOPATH/src/<import>`.

# Getting Started

Install `gfi.vim`:

Using vim-pack:

- `git clone https://github.com/kkoomen/gfi.vim ~/.vim/pack/<dir>/start/gfi`

Using pathogen:

- `git clone https://github.com/kkoomen/gfi.vim ~/.vim/bundle/gfi`

# Configuration

## `g:gfi_open_file_command`

    default: 'edit'

    Define the command which will open the file or directory.
    For example: vsplit, split, tabnew, edit, etc...

# Contributing

Help or feedback is always appreciated. If you find any bugs or improvements,
feel free to submit a pull request.

## Linting

Your pull request should follow the rules of the `vim-vint` linter which is a
must to keep your code clean and prevent mistakes being made.

- `pip3 install vim-vint`

If you use [ALE](https://github.com/w0rp/ale) (recommended)

```
let g:ale_linters = { 'vim': ['vint'] }
```

or if you use [Syntastic](https://github.com/vim-syntastic/syntastic)
```
let g:syntastic_vim_checkers = ['vint']
```

## Documentation

Every function, mapping or configurable option should contain documentation. The
documentation in the `doc/` should be generated using [vimdoc](https://github.com/google/vimdoc).

# License

Copyright 2019 Kim Koomen

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
