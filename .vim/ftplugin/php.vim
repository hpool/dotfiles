""
" PHP Lint

"augroup gPHPLint
"    autocmd!
"    autocmd BufWritePost *.php :call PHPLint()
"augroup END

function! PHPLint()
  let result = system( &ft . ' -l ' . bufname(""))
  let headPart = strpart(result, 0, 16)
  if headPart != "No syntax errors"
    echo result
  endif
endfunction

nnoremap <buffer> ,l  :<C-u>execute '!' &l:filetype '-l' shellescape(expand('%'))<Return>

:set makeprg=php\ -l\ %
:set errorformat=%m\ in\ %f\ on\ line\ %l

let php_sql_query=1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1

nnoremap <buffer> <F1> :vimgrep /\s*function / %<CR>:cw<CR>

" phpmd
let g:php_md_path = get(g:, 'php_md_path', 'phpmd')
let g:php_md_rule_set = get(g:, 'php_md_rule_set', 'unusedcode,design,codesize')

function! PhpmdDirectory()
    call s:phpmd(expand('%:p:h'))
endfunction

function! PhpmdFile()
    call s:phpmd(expand('%:ph'))
endfunction

function! s:phpmd(path)
    let command = g:php_md_path.' '.a:path.' text '.g:php_md_rule_set
    echohl Title | echo command | echohl None
    let output = system(command)
    let output_list = split(output, "\n")

    set errorformat=%E%f:%l%m
    cgetexpr output_list
    copen
    redraw!
endfunction

nnoremap <silent><leader>pmd :call PhpmdDirectory()<CR>
nnoremap <silent><leader>pmf :call PhpmdFile()<CR>


