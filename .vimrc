set nocompatible               " be iMproved
filetype off                   " required!

if has('vim_starting')
  " git submodule update --init
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', { 'build' : {
    \       'cygwin' : 'make -f make_cygwin.mak',
    \       'mac' : 'make -f make_mac.mak',
    \       'unix' : 'make -f make_unix.mak',
    \   },
    \}

NeoBundle 'sudo.vim'
NeoBundle 'ack.vim'
NeoBundle 'grep.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'hpool/buftabs'
"NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'kien/ctrlp.vim'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'gregsexton/gitv'

NeoBundle 'php.vim--Garvin'
NeoBundle 'stephpy/vim-php-cs-fixer'
NeoBundle 'soh335/vim-symfony'
NeoBundle 'karakaram/vim-quickrun-phpunit'

NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'SrcExpl'
NeoBundle 'Trinity'
NeoBundle 'taglist.vim'

NeoBundle 'ciaranm/inkpot'

NeoBundle 'mattn/webapi-vim'

filetype plugin indent on     " required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

" .vim/rc/color.vim
" .vim/rc/basic.vim
" .vim/after/plugin/mappings.vim
" .vim/after/plugin/local.vim

if filereadable(expand('~/.vim/rc/basic.vim'))
  source ~/.vim/rc/basic.vim
endif

source $VIMRUNTIME/macros/matchit.vim

let s:endpoint = 'http://services.gingersoftware.com/Ginger/correct/json/GingerTheText'
let s:apikey = '6ae0c3a0-afdc-4532-a810-82ded0054236'
function! s:ginger(text)
  let res = webapi#json#decode(webapi#http#get(s:endpoint, {
    \ 'lang': 'US',
    \ 'clientVersion': '2.0',
    \ 'apiKey': s:apikey,
    \ 'text': a:text}).content)
  let i = 0
  for rs in res['LightGingerTheTextResult']
    let [from, to] = [rs["From"], rs["To"]]
    if i < from
    echon a:text[i : from-1]
    endif
    echohl WarningMsg
    echon a:text[from : to]
    echohl None
    let i = to + 1
  endfor
  if i < len(a:text)
    echon a:text[i :]
  endif
endfunction

command! -nargs=+ Ginger call s:ginger(<q-args>)


" plugin
"--------------------------------------------------
" quickrun
augroup QuickRunPHPUnit
  autocmd!
  autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.unit
augroup END

" 初期化
let g:quickrun_config = {}
" PHPUnit
let g:quickrun_config['php.unit'] = {}
let g:quickrun_config['php.unit'] = {
\   'outputter': 'phpunit',
\   'command': 'phpunit',
\   'cmdopt': '',
\   'exec': '%c %o %s',
\}

"--------------------------------------------------
" gitgutter
let g:gitgutter_realtime = 0

"--------------------------------------------------
" syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_php_checkers=['php']
let g:syntastic_php_phpmd_post_args='text codesize,design,unusedcode'

"--------------------------------------------------
" vimshell
nnoremap <silent> ,sh :VimShell<CR>

"--------------------------------------------------
" NERDTree
let g:NERDTreeHijackNetrw = 0

"--------------------------------------------------
" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

"--------------------------------------------------
" ack.vim
nnoremap <C-g><C-a> :Ack<Space><C-r><C-w><Enter>

"--------------------------------------------------
" vim-php-cs-fixer
let g:php_cs_fixer_path = "~/bin/php-cs-fixer.phar"

let g:php_cs_fixer_dry_run = 1                  " Call command with dry-run option
let g:php_cs_fixer_verbose = 1                  " Return the output of command if 1, else an inline information.
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

"--------------------------------------------------
" buftabs
" .vim/bundle/buftabs/plugin/buftabs.vim
"http://vim.sourceforge.net/scripts/script.php?script_id=1664
let g:buftabs_active_highlight_group="Visual"
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1

"--------------------------------------------------
" MiniBufExplorer
"let g:miniBufExplSplitBelow = 1
"let g:miniBufExplVSplit = 30
"let g:miniBufExplorerMoreThanOne = 0

"--------------------------------------------------
" grep.vim
" :Gb <args> でGrepBufferする
command! -nargs=1 GB :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>
nnoremap <C-g><C-g> :grep<Space><C-r><C-w><Space>.<Enter>

"--------------------------------------------------
" YankRing
" http://www.vim.org/scripts/script.php?script_id=1234
nmap ,y :YRShow<CR>
let g:yankring_history_file = '.vim_yankring_history'

"--------------------------------------------------
" ctrlp
let g:ctrlp_map = ',p'


"--------------------------------------------------
" SrcExpl.vim
nmap <C-I> <C-W>j:call g:SrcExpl_Jump()<CR>

"--------------------------------------------------
" autocomplpop.vim
" http://www.vim.org/scripts/script.php?script_id=1879

"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
"function! InsertTabWrapper()
"    if pumvisible()
"        return "\<C-N>"
"    else
"
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<TAB>"
"    elseif exists('&omnifunc') && &omnifunc == ''
"        return "\<C-N>"
"    else
"        return "\<C-N>\<C-P>"
"    endif
"endfunction

" Remap the tab key to select action with InsertTabWrapper
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

" php.dict: http://coderepos.org/share/browser/lang/php/misc/dict.php
"autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
"autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'
"autocmd FileType php :set dictionary=~/.vim/dict/php.dict
"
"let g:AutoComplPop_IgnoreCaseOption = 1


"--------------------------------------------------
" surround
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


"--------------------------------------------------
" unite.vim
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"

noremap ,ud :UniteWithBufferDir file -buffer-name=file<CR>
noremap ,uf :Unite -buffer-name=file file<CR>
noremap ,ub :Unite buffer_tab<CR>
noremap ,um :Unite file_mru<CR>
noremap ,uc :UniteWithCurrentDir file_mru<CR>
noremap ,uk :Unite bookmark<CR>
noremap ,ur :Unite -buffer-name=register register<CR>
noremap ,uo :Unite outline<CR>
noremap ,uO :<C-u>Unite -vertical -no-quit -no-start-insert -no-focus outline<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


autocmd BufEnter *
    \   if empty(&buftype)
    \|      nnoremap <buffer> g<C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
    \|  endif

"--------------------------------------------------
" vim-ref
" http://www.php.net/get/php_manual_en.tar.gz/from/jp1.php.net/mirror
let g:ref_phpmanual_path = $HOME . '/.vim/manual/php'
noremap rphp :Ref phpmanual 
noremap rpy :Ref pydoc 
noremap ra :Ref alc 


"--------------------------------------------------
" neocomplcache
set completeopt=menuone
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'scala' : $HOME.'/.vim/dict/scala.dict'
    \ }
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'


"--------------------------------------------------
" neosnippet
imap <C-s>  <Plug>(neocomplcache_start_unite_snippet)

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


"--------------------------------------------------
" gitv
autocmd FileType git setlocal nofoldenable foldlevel=0
function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction

autocmd FileType gitv call s:my_gitv_settings()
function! s:my_gitv_settings()
  setlocal iskeyword+=/,-,.
  nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
  nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w
endfunction
