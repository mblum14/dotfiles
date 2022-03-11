command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

augroup fzf
  autocmd! FileType fzf
  autocmd! FileType fzf set laststatus=0 noshowmode noruler nonu
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_git_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
