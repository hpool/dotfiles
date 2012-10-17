set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'ack.vim'
Bundle 'YankRing.vim'
Bundle 'buftabs'
Bundle 'ciaranm/inkpot'
Bundle 'Shougo/unite.vim'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'Shougo/neocomplcache'
Bundle 'soh335/vim-symfony'
Bundle 'grep.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'sudo.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'Source-Explorer-srcexpl.vim'
Bundle 'php.vim--Garvin'
Bundle 'stephpy/vim-php-cs-fixer'


filetype plugin indent on     " required!


" .vim/plugin/basic.vim
" .vim/plugin/local.vim
" .vim/plugin/mappings.vim
if filereadable(expand('~/.vim/plugin/basic.vim'))
  source ~/.vim/plugin/basic.vim
endif
if filereadable(expand('~/.vim/plugin/local.vim'))
  source ~/.vim/plugin/local.vim
endif
if filereadable(expand('~/.vim/plugin/mappings.vim'))
  source ~/.vim/plugin/mappings.vim
endif




" plugin

"--------------------------------------------------
" vim-php-cs-fixer
let g:php_cs_fixer_path = "~/bin/php-cs-fixer.phar"

"--------------------------------------------------
" buftabs
" .vim/bundle/buftabs/plugin/buftabs.vim
"http://vim.sourceforge.net/scripts/script.php?script_id=1664
let g:buftabs_active_highlight_group="Visual"
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1

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
" MiniBufExplorer
"nmap <Space> :MBEbn<CR>
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplSplitBelow = 0
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplSplitToEdge = 1


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

noremap ,ud :UniteWithBufferDir file -buffer-name=file<CR>
noremap ,uf :Unite -buffer-name=file file<CR>
noremap ,ub :Unite buffer_tab<CR>
noremap ,um :Unite file_mru<CR>
noremap ,uc :UniteWithCurrentDir file_mru<CR>
noremap ,uk :Unite bookmark<CR>
noremap ,ur :Unite -buffer-name=register register<CR>
noremap ,uo :Unite outline<CR>

" ESCキーを2回押すと終了する
autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


"--------------------------------------------------
" vim-ref
let g:ref_phpmanual_path = $HOME . '/ref/php'
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
	"let g:neocomplcache_dictionary_filetype_lists = {
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
	imap <C-k>     <Plug>(neocomplcache_snippets_expand)
	smap <C-k>     <Plug>(neocomplcache_snippets_expand)
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
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

