set exrc " open project .nvimrc

let g:polyglot_disabled = ['typescript', 'typescriptreact', 'python']
call plug#begin('~/.config/nvim/plugged')

" Speed up startup time
Plug 'lewis6991/impatient.nvim'

" lua utilities
Plug 'nvim-lua/plenary.nvim'

" look and feel
Plug 'ellisonleao/gruvbox.nvim'     " theme
Plug 'kyazdani42/nvim-web-devicons' " icons
"Plug 'feline-nvim/feline.nvim'      " statusbar
Plug 'nvim-lualine/lualine.nvim'    " statusbar
Plug 'SmiteshP/nvim-gps'            " code context
Plug 'akinsho/nvim-bufferline.lua'  " bufferline

" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc', 'do': ':UpdateRemotePlugins' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" snippets
Plug 'hrsh7th/vim-vsnip'

" lsp
Plug 'folke/lsp-colors.nvim'
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'

" lsp sources
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'f3fora/cmp-spell'
Plug 'jose-elias-alvarez/null-ls.nvim'

" lsp customizations
Plug 'folke/trouble.nvim'   " pretty diagnostic lists
Plug 'onsails/lspkind-nvim' " add icons to built-in lsp

" syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" dashboard
Plug 'goolord/alpha-nvim'

" tools
Plug 'rcarriga/nvim-notify'                " Notifications
Plug 'folke/which-key.nvim'                " Show key bindings
Plug 'andymass/vim-matchup'                " highlight/navigate/operate on sets of matching text
Plug 'norcalli/nvim-colorizer.lua'         " show colors
Plug 'godlygeek/tabular'                   " auto align
Plug 'christoomey/vim-tmux-navigator'      " tmux navigation bindings
Plug 'chrisbra/NrrwRgn'                    " narrow region
Plug 'mattn/emmet-vim'                     " emmet
Plug 'tpope/vim-repeat'                    " repeat surround commands
Plug 'tpope/vim-surround'                  " surround text utilities
Plug 'tpope/vim-unimpaired'                " handy mappings
Plug 'tpope/vim-vinegar'                   " netrw customizations

call plug#end()

lua require'impatient'.enable_profile()

let g:loaded_matchit = 1

autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()

" ================ Autoreload vimrc ================= "
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

