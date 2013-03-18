alias fcd='cd `$HOME/bin/fcd.sh`'
alias gvim="open -a MacVim"
alias s="say"

if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias vim=vi
fi


export GIT_PAGER="lv -c"

