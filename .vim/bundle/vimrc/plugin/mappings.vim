
" mappings.vim
"
" ~/.vimrc

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" Insertモード時にCtrl+Bでカーソル上の一文字削除
imap <C-B> <C-O>x

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>


" 選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>


nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" alternate file
nmap ^ <C-^>

vnoremap * "zy:let @/ = @z<CR>n

nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>

"omnifunction
imap <C-f> <C-x><C-o>

