behave mswin
syntax on
set number
set history=1000
set showcmd
set showmode
set visualbell
set autoread
set shell=/bin/bash
set tags=./tags
set hidden

set splitbelow splitright
set cursorline

" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
