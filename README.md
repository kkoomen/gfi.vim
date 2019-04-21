# gf.vim

An improved version of the `gf` mapping in Vim, which opens the file under the
cursor, but now in a smarter way.

# Table of Contents
1. [How It Works](#how-it-works)
2. [Getting Started](#getting-started)
3. [Configuration](#configuration)
  1. [g:gf_open_file_command](#g-gf-open-file-command)
4. [Contributing](#contributing)
  1. [Linting](#linting)
5. [License](#License)

# How It Works

Files will be resolved now based on its path:<br />
- relative to the current buffer
- relative to vim's current working directory
- based on the git directory it is located in (absolute imports)

Files will also be checked in a more advanced way per filetype when it can:

- javascript / typescript / jsx
    Since most javascript projects these days use webpack to resolve their
    import statements. This module is also able to resolve these import paths,
    relative or absolute. Javascript-like filetype buffers will also try to
    resolve paths based on:

    - The 'moduleRoots' property in the `package.json` of the project.
    - Whether the input is a directory and if it is, it will look for an `index`
      file in that directory, since webpack is resolving `index` files if a
      directory is imported.

# Getting Started

Install `gf.vim`:

Using vim-pack:

- `git clone https://github.com/kkoomen/gf.vim ~/.vim/pack/<dir>/start/gf`

Using pathogen:

- `git clone https://github.com/kkoomen/gf.vim ~/.vim/bundle/gf`

# Configuration

## `g:gf_open_file_command`
    ```
    default: 'edit'

    Define the command which will open the file or directory.
    For example: vsplit, split, tabnew, edit, etc...
    ```

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
