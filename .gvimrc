" ~/.gvimrc
if has('gui_macvim')
    set antialias

    set visualbell
    set columns=100
    set fuopt+=maxhorz   " フルスクリーン時に横幅を最大にする

    "gt, gT コマンドでタブを切り替え
    map <silent> gt :tabnext<CR>
    map <silent> gT :tabprev<CR>

    set guioptions=egmrLt
    set cmdheight=1

    "バックアップファイルを作成しない
    set nobackup
    map gw :macaction selectNextWindow:<CR>
    map gW :macaction selectPreviousWindow:<CR>

    augroup focus_transparency
      autocmd FocusGained * set transparency=20
      autocmd FocusLost * set transparency=40
    augroup END

    colorscheme koehler
    hi Visual term=reverse cterm=reverse gui=reverse guibg=grey20

    " IMEの状態でカーソルの色を変更する
    highlight Cursor guifg=NONE guibg=Green
    highlight CursorIM guifg=NONE guibg=Purple

    highlight CursorLine term=underline cterm=underline guibg=#333344
    set hi cursorline

    set directory=~/tmp/.vim/
endif
