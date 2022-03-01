set exrc " open project .nvimrc

let g:polyglot_disabled = ['typescript', 'typescriptreact', 'python']
call plug#begin('~/.config/nvim/plugged')

" lua utilities
Plug 'nvim-lua/plenary.nvim'

" look and feel
Plug 'ellisonleao/gruvbox.nvim' " theme
Plug 'kyazdani42/nvim-web-devicons' "icons
Plug 'feline-nvim/feline.nvim' "statusbar
Plug 'akinsho/bufferline.nvim' "bufferline
Plug 'norcalli/nvim-colorizer.lua'

" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
"Plug 'mhinz/vim-signify'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc', 'do': ':UpdateRemotePlugins' }

" lsp
" TODO

" syntax highlighting
" TODO

" tools
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chrisbra/NrrwRgn'
Plug 'mattn/emmet-vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'ap/vim-css-color'

call plug#end()

set termguicolors
set background=dark
colorscheme gruvbox

lua <<EOF
require('colorizer').setup()
require('colors').init()
require('devicons').setup()
require('gitsigns').setup()
require('bufferline')
require('statusline').setup()
EOF

" ================ Autoreload vimrc ================= "
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

