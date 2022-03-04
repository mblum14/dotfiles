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

nnoremap <c-p> :GFiles<CR>

inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

augroup fzf
  autocmd! FileType fzf
  autocmd! FileType fzf set laststatus=0 noshowmode noruler nonu
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_git_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'

nmap <space>s [fzf-s]
xmap <space>s [fzf-s]c
nnoremap <silent> [fzf-s]/ :Rg<CR>
nnoremap <c-p>/ :Rg<CR>
nnoremap <silent> [fzf-s]r :Rg<CR>
nnoremap <silent> [fzf-s]p  :GFiles<CR>

nmap <space>f [fzf-f]
xmap <space>f [fzf-f]

nnoremap <silent> [fzf-f]p     :<C-u>FzfPreviewFromResourcesRpc project_mru git<CR>
nnoremap <silent> [fzf-f]gs    :<C-u>FzfPreviewGitStatusRpc<CR>
nnoremap <silent> [fzf-f]ga    :<C-u>FzfPreviewGitActionsRpc<CR>
nnoremap <silent> [fzf-f]b     :<C-u>FzfPreviewBuffersRpc<CR>
nnoremap <silent> [fzf-f]B     :<C-u>FzfPreviewAllBuffersRpc<CR>
nnoremap <silent> [fzf-f]o     :<C-u>FzfPreviewFromResourcesRpc buffer project_mru<CR>
nnoremap <silent> [fzf-f]<C-o> :<C-u>FzfPreviewJumpsRpc<CR>
nnoremap <silent> [fzf-f]g;    :<C-u>FzfPreviewChangesRpc<CR>
nnoremap <silent> [fzf-f]/     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-f]*     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-f]gr    :<C-u>FzfPreviewProjectGrepRpc<Space>
xnoremap          [fzf-f]gr    "sy:FzfPreviewProjectGrepRpc<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-f]t     :<C-u>FzfPreviewBufferTagsRpc<CR>
nnoremap <silent> [fzf-f]q     :<C-u>FzfPreviewQuickFixRpc<CR>
nnoremap <silent> [fzf-f]l     :<C-u>FzfPreviewLocationListRpc<CR>
