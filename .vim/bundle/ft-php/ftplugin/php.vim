""
" PHP Lint

augroup gPHPLint
    autocmd!
    autocmd BufWritePost *.php :call PHPLint()
augroup END

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
let php_htmlInStrings=1
