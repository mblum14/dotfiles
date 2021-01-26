set exrc " open project .nvimrc

call plug#begin('~/.config/nvim/plugged')
" look and feel
Plug 'gruvbox-community/gruvbox'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" syntax highlighting
Plug 'm-kat/aws-vim'
Plug 'chr4/nginx.vim'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/yajs.vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'chrisbra/NrrwRgn'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

call plug#end()

" ================ Autoreload vimrc ================= "
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
