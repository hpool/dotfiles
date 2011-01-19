
stty stop undef

# Enable compsys completion.
autoload -U compinit
compinit

bindkey -e

#PAGER
if [ -x "`which lv 2>/dev/null`" ]; then
    export PAGER=lv
elif [ -x "`which less 2>/dev/null`" ]; then
    export PAGER=less
else
    export PAGER=more
fi


if [ -x "`which vim 2>/dev/null`" ]; then
    export SVN_EDITOR=vim
    export EDITOR=vim
elif [ -x "`which vi 2>/dev/null`" ]; then
    export SVN_EDITOR=vi
    export EDITOR=vi
fi

setopt always_last_prompt
setopt append_history
setopt auto_cd
setopt auto_pushd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_resume
setopt NO_beep
#setopt brace_cd
setopt NO_flow_control
setopt hist_verify
setopt ignore_eof
setopt list_types
setopt mark_dirs
#setopt transient_rprompt
setopt correct
setopt list_packed


# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_space
setopt extended_history
setopt share_history
function history-all { history -E 1 }

# color
local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'

#PROMPT=$BLUE'[${USER}@${HOST}] %(!.#.$) '$WHITE
#PROMPT=$BLUE'[${USER}@${HOSTNAME}] %(!.#.$) '$DEFAULT
#RPROMPT=$GREEN'[%~]'$DEFAULT

# prompt
local PROMPT_RED=$'%{\e[1;$[31]m%}'
local PROMPT_COLOR=$'%{\e[1;$[32+$RANDOM % 5]m%}'
PROMPT_COLOR="%(?.$PROMPT_COLOR.$PROMPT_RED)"
PROMPT=$PROMPT_COLOR'%B%U%m'"{%n}%#$DEFAULT%u%b "
RPROMPT=$PROMPT_COLOR'%B[%(?.%h.ERROR:%?)] %D{%m/%d %R} [%3c]'$DEFAULT'%b'
SPROMPT='Correct> '\''%r'\'' [Yes No Abort Edit] ? '

setopt PROMPT_SUBST

#PROMPT="%{^32m%}[$WINDOW]%{^m%}\$ "
#RPROMPT='%{^34m%}[%5~]%{^00m%}'

if [ `uname` = "Linux" ]; then
    alias ls='ls --color=auto'
else
    alias ls='ls -FG'
fi
alias ll='ls -la'

alias lv="lv -c"

alias -g L="| $PAGER"
alias -g G="| grep"

alias grep='grep --color'

if [ -x "`which vim 2>/dev/null`" ]; then
  alias vi='vim'
fi

alias bd="popd"

export MYSQL_PS1='\u@\h:\d> '

# dabbrev
HARDCOPYFILE=$HOME/tmp/screen-hardcopy
touch $HARDCOPYFILE

dabbrev-complete () {
        local reply lines=80 # 80line
        screen -X eval "hardcopy -h $HARDCOPYFILE"
        reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
        compadd - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^_' reverse-menu-complete

#####################

#function chpwd(){
# ll
#}

function cdup(){
 echo
 cd ..
 zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup


function ssh_screen(){
 eval server=\${$#}
 screen -t $server ssh "$@"
}

if [ x$TERM = xscreen -o $TERM = "xterm-256color" ]; then
  alias ssh=ssh_screen
fi


if [ "$TERM" = screen -o "$TERM" = "xterm-256color" ]; then
    chpwd () { echo -n "_`dirs`\\" && ll }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})
        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi

# Host zshrc
h="${HOST%%.*}"
if [[ -f "$HOME/.zsh/host-$h.zshrc" ]]; then
    source "$HOME/.zsh/host-$h.zshrc"
fi


# CPAN(local::lib)
if [ -x $HOME/local/lib/perl5 ]; then
    eval $(perl -I$HOME/local/lib/perl5 -Mlocal::lib=$HOME/local)
fi


# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
if [[ $VIRTUALENVWRAPPER_INITIALIZED -ne 1 ]] && [ -f ~/.virtualenvwrapper.sh ]; then
  source ~/.virtualenvwrapper.sh
  export VIRTUALENVWRAPPER_INITIALIZED=1
fi

# vcs_info
autoload -Uz add-zsh-hook
autoload -Uz colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.7; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
  function _update_vcs_info_msg() {
      psvar=()
      LANG=en_US.UTF-8 vcs_info
      [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
  }
  add-zsh-hook precmd _update_vcs_info_msg
  #RPROMPT="%1(v|%F{green}%1v%f|)"
  RPROMPT="%1(v|%F{green}%1v%f|)"$RPROMPT
fi

