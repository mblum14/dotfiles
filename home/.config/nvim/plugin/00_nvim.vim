" ================ General Config ====================

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


" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" ================ Search Settings  =================

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowritebackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.local/backups > /dev/null 2>&1
set undodir=~/.local/backups
set undofile
set undolevels=1000
set undoreload=10000

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set cindent
set cinwords=if,else,while,do,for,switch,case,module,def,class,elsif

set nowrap
set linebreak
set nojoinspaces

" ================ Trailing Whitespace ==============
set list
set listchars=
set listchars+=tab:→\ 
set listchars+=trail:·
set listchars+=extends:»              " show cut off when nowrap
set listchars+=precedes:«
set listchars+=nbsp:⣿

" ================ Folds ============================

set foldmethod=indent
set foldnestmax=3
set nofoldenable

" ================ Window Splitting =================

set splitbelow
set splitright
set fillchars=vert:│                  " Vertical sep between windows (unicode)
set hidden                            " remember undo after quitting
" reveal already opened files from the quickfix window instead of opening new
" buffers
set switchbuf=useopen
set nostartofline                     " don't jump to col1 on switch buffer

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*sass-cache*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=/node_modules/*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so
set wildignore+=*.swp
set wildignore+=*.zip

" ================ Colors ===========================
set termguicolors
set background=dark
colorscheme gruvbox
let colorcolumn="120"
highlight colorcolumn ctermbg='0'
set syntax=automatic
set cursorline
highlight clear SignColumn
highlight clear LineNr

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set cmdheight=2
set shortmess+=c

