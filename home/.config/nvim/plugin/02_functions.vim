command! FormatJSON :%!python -m json.tool
nnoremap = :FormatJSON<CR>

function! g:FindGitRoot()
  return system('git rev-parse --show-toplevel 2> /dev/nul')[:-2]
endfunction

function! s:RunTestFromProjectRoot(command) abort
  let g:test#project_root = FindGitRoot()
  execute a:command
endfunction

command! -nargs=1 RunTestFromProjectRoot call s:RunTestFromProjectRoot(<f-args>)
