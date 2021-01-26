set guifont=PowerlineSymbols
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
