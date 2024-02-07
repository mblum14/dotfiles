" ================ Mappings =========================
let mapleader = ','
:imap jj <Esc>
:imap Jj <Esc>
:imap uuu _
:imap hhh =>
:imap aaa @
:map <S-Enter> 0<Esc>
:map <Enter> o<Esc>

nnoremap Q @q

" May Y yank to end of line from current position
nnoremap Y y$

nnoremap <leader>c :cclose<BAR>lclose<CR>

nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprev<CR>zz

:nmap <C-t> :tabnew<CR>
:imap <C-t> <Esc>:tabnew<CR>
:nnoremap <silent> ]t :tabnext<CR>
:nnoremap <silent> [t :tabpreviouis<CR>
:nnoremap <silent> <C-Right> :tabnext<CR>
:nnoremap <silent> <C-Left> :tabprevious<CR>

" turn off highlighting
:nmap <leader>h :nohl<CR>

" close quickfix
autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
  \ q :cclose<CR>:lclose<CR>
autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) | bd | q | endif

" re-select last visual selection
nnoremap gp '[v']

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-j> :cnext<CR>zzzv

" Moving text
"inoremap <C-j> <esc>:m .+1<CR>==
"inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
