
" mappings.vim
"
" ~/.vimrc

" Insertモード時にCtrl+Bでカーソル上の一文字削除
imap <C-B> <C-O>x

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>


"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" 検索などで飛んだらそこを真ん中に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" 選択した文字列を検索
vnoremap * "zy:let @/ = @z<CR>n
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>


" alternate file
nmap ^ <C-^>

nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>

"omnifunction
imap <C-f> <C-x><C-o>

nnoremap ; :

" Vim(Mac)
if has('mac') && !has('gui')
    nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
    vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
    nnoremap <silent> <Space>p :r !pbpaste<CR>
    vnoremap <silent> <Space>p :r !pbpaste<CR>
" GVim(Mac & Win)
else
    noremap <Space>y "+y
    noremap <Space>p "+p
endif

