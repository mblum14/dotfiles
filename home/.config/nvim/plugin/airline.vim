set guifont=PowerlineSymbols
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#nrrwrgn = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 5
"let g:ale_sign_error = 'x' # TODO
"let g:ale_sign_warning = '!' # TODO
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%] (%code% - %severity%) %s'
let g:ale_python_pylint_change_directory = 1
let g:ale_python_pylint_auto_pipenv = 1
let g:ale_virtualenv_dir_names = ['.venv']
let g:ale_pattern_options_enabled = 1
