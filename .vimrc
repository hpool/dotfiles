syntax on

if filereadable(expand('~/.vim/autoload/pathogen.vim'))
  call pathogen#runtime_append_all_bundles()
endif

if filereadable(expand('~/.vim/color.vimrc'))
  source ~/.vim/color.vimrc
endif

set autoindent
set number
set wrapscan
set showmatch
set showmode
set laststatus=2
set showcmd
"set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
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
"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" Insertモード時にCtrl+Bでカーソル上の一文字削除
imap <C-B> <C-O>x

set fileformats=unix,dos,mac

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

highlight SpecialKey guibg=#222222 cterm=underline ctermfg=darkgrey
set list
set listchars=tab:>-,extends:<,trail:\ 

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

"
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" 選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>


highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

vnoremap * "zy:let @/ = @z<CR>n

nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>

"omnifunction
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"buftabs
"http://vim.sourceforge.net/scripts/script.php?script_id=1664
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1

"MRU
"http://www.vim.org/scripts/script.php?script_id=521
let MRU_Max_Entries=20
let MRU_Window_Height=15

"YankRing
"http://www.vim.org/scripts/script.php?script_id=1234
nmap ,y :YRShow<CR>


"MiniBufExplorer
"nmap <Space> :MBEbn<CR>
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplSplitBelow = 0
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplSplitToEdge = 1

imap <C-f> <C-x><C-o>

" autocomplpop.vim
" http://www.vim.org/scripts/script.php?script_id=1879

"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
    if pumvisible()
        return "\<C-N>"
    else

    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<C-N>"
    else
        return "\<C-N>\<C-P>"
    endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

" php.dict: http://coderepos.org/share/browser/lang/php/misc/dict.php
autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'
autocmd FileType php :set dictionary=~/.vim/dict/php.dict


let g:AutoComplPop_IgnoreCaseOption = 1

"surround
" http://www.vim.org/scripts/script.php?script_id=1697
autocmd FileType php,html let b:surround_45 = "<?php \r ?>" " 45 = -

autocmd FileType php,html let b:surround_49  = "<h1>\r</h1>" " 1 : <h1>|</h1>
autocmd FileType php,html let b:surround_50  = "<h2>\r</h2>" " 2 : <h2>|</h2>
autocmd FileType php,html let b:surround_51  = "<h3>\r</h3>" " 3 : <h3>|</h3>
autocmd FileType php,html let b:surround_52  = "<h4>\r</h4>" " 4 : <h4>|</h4>
autocmd FileType php,html let b:surround_53  = "<h5>\r</h5>" " 5 : <h5>|</h5>
autocmd FileType php,html let b:surround_54  = "<h6>\r</h6>" " 6 : <h6>|</h6>

autocmd FileType php,html let b:surround_112 = "<p>\r</p>" " p : <p>|</p>
autocmd FileType php,html let b:surround_117 = "<ul>\r</ul>" " u : <ul>|</ul>
autocmd FileType php,html let b:surround_111 = "<ol>\r</ol>" " o : <ol>|</ol>
autocmd FileType php,html let b:surround_108 = "<li>\r</li>" " l : <li>|</li>
autocmd FileType php,html let b:surround_97  = "<a href=\"\">\r</a>" " a : <a href=>|</a>
autocmd FileType php,html let b:surround_65  = "<a href=\"\r\"></a>" " A : <a href=|></a>
autocmd FileType php,html let b:surround_105 = "<img src=\"\r\" alt=\"\" />" " i : <img src=| alt= />
autocmd FileType php,html let b:surround_73  = "<img src=\"\" alt=\"\r\" />" " I : <img src= alt| />
autocmd FileType php,html let b:surround_100 = "<div>\r</div>" " d : <div>|</div>

" unite.vim
let g:unite_enable_start_insert = 1

noremap ud :UniteWithBufferDir file -buffer-name=file<CR>
noremap uf :Unite -buffer-name=file file<CR>
noremap ub :Unite buffer_tab<CR>
noremap um :Unite file_mru<CR>
noremap uc :UniteWithCurrentDir file_mru<CR>
noremap uk :Unite bookmark<CR>

" ESCキーを2回押すと終了する
autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)

call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)

call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^\\', '~/*')

call unite#set_substitute_pattern('file', '^;v', '~/.vim/*')
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/*"')
if has('win32') || has('win64')
  call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/*')
endif

call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)

