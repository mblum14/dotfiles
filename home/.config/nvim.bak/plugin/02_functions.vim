command! FormatJSON :%!python -m json.tool
nnoremap = :FormatJSON<CR>
