if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info --bind alt-a:select-all'
 endif
 function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
 endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'}

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:float_preview#docked = 1
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:float_preview#max_width = 50
let g:float_preview#auto_close = 1

augroup fzf
  autocmd! FileType fzf
  autocmd! FileType fzf set laststatus=0 noshowmode noruler nonu
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_git_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_grep_command = 'rg --column --line-number --no-heading --color=never --smart-case --hidden'
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_directory_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_git_status_command = 'git -c color.status=always status --short --untracked-files=all'

let g:fzf_preview_use_dev_icons = 1
let g:fzf_preview_default_fzf_options = { '--reverse': v:true, '--preview-indow': 'wrap' }
let g:fzf_preview_preview_key_bindings = 'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'
