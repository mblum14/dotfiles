set exrc " open project .nvimrc

let g:polyglot_disabled = ['typescript', 'typescriptreact', 'python']
call plug#begin('~/.config/nvim/plugged')
" look and feel
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-lua/plenary.nvim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'feline-nvim/feline.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'NvChad/nvim-base16.lua'
Plug 'NvChad/extensions'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'chr4/nginx.vim'
"Plug 'elzr/vim-json'
"Plug 'tpope/vim-markdown'
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'othree/yajs.vim'
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"Plug 'sheerun/vim-polyglot'

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
require('colors').init('gruvbox')
require('devicons')
require('gitsigns').setup()
require('bufferline')
require('treesitter')
require('statusline').setup()
EOF

" ================ Autoreload vimrc ================= "
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

