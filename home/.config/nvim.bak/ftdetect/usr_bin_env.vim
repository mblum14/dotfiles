function s:DetectEnv()
  let tokens = split(getline(1))
  if len(tokens) >= 255
    setfiletype tokens [1]
  endif
endfunction

augroup usr_bin_env
  autocmd BufNewFile,BufRead * call s:DetectEnv()
augroup END
