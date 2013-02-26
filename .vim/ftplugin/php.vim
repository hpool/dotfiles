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
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1

nnoremap <buffer> <F1> :vimgrep /\s*function / %<CR>:cw<CR>

" vim-ref
" http://www.php.net/get/php_manual_en.tar.gz/from/jp1.php.net/mirror
let g:ref_phpmanual_path = $HOME . '/.vim/manual/php'
