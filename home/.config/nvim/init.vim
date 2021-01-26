set exrc " open project .nvimrc

call plug#begin(stdpath('data') . '/plugged')
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


colorscheme gruvbox

let mapleader = " "
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

nnoremap <c-p> :GGrep<CR>
nnoremap <leader>p :GGrep<CR>

" airline
set guifont=PowerlineSymbols
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1

" ================ Autoreload vimrc ================= "
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
