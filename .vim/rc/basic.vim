
" basic.vim
"
" ~/.vimrc

syntax on

" ~/.vim/rc/color.vim
if filereadable(expand('~/.vim/rc/color.vim'))
  source ~/.vim/rc/color.vim
endif


set autoindent
set number
set wrapscan
set showmatch
set showmode
set laststatus=2
set showcmd
set statusline=%<%f\%m%r%h%w%=%{'['.(&fenc!=''?&fenc:&enc).'/'.&ff.']'}%3l,%3v%4P
set grepprg=grep\ -rnIH\ $*\ /dev/null

set nowildmenu
set wildmode=longest:list,full

set backspace=2
set nolist
set title
set ruler
set scrolloff=3 " スクロール時の余白確保

set hidden

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set ignorecase
set smartcase
"set nohlsearch
set incsearch

set encoding=utf-8
set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2
set fileformats=unix,dos,mac


" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = s:fileencodings_default .','. &fileencodings
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif


" 全角スペース/行末スペースをハイライト
if has("syntax")
  function! SetSpacesHighlight()
    highlight WhitespaceEOL gui=underline guifg=red guibg=red cterm=underline ctermfg=red ctermbg=red
    highlight JISX0208Space gui=underline guifg=lightblue cterm=underline ctermfg=lightblue
  endfunction

  call SetSpacesHighlight()
  augroup HighlightSpaces
    autocmd!
    autocmd VimEnter,ColorScheme * call SetSpacesHighlight()
    autocmd VimEnter,WinEnter,BufNew,BufRead * match WhitespaceEOL /\s\+$/
    autocmd VimEnter,WinEnter,BufNew,BufRead * call matchadd("JISX0208Space", "　")
  augroup END
endif

" SpecialKey
highlight SpecialKey guibg=#222222 cterm=underline ctermfg=darkgrey
set list
set listchars=tab:>-,extends:<


" Insertモード時にStatus Lineの色を変える
if ! exists("g:hi_insert")
  let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=grey ctermbg=darkmagenta cterm=none'
endif

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4


autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

autocmd FileType php,html :setlocal includeexpr=substitute(v:fname,'^\\/','','')
