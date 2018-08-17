export HOMEBREW_CASK_OPTS="--appdir=/Applications"

source /usr/local/git/contrib/completion/git-prompt.sh
source /usr/local/git/contrib/completion/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
# export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[31m\] $(__git_ps1 "\[\033[01;33m\]{%s}")\[\033[1;31m\]$\[\033[00m\] '

alias ssh=~/bin/ssh-change-profile.sh


# git-prompt settings
if [ -f .git-prompt.sh ]; then
    source .git-prompt.sh
    export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[31m\] $(__git_ps1 "\[\033[01;33m\]{%s}")\[\033[1;31m\]$\[\033[00m\] '
    # export PS1='[\u@\[\e[44;97m\]\H\[\e[00m\] \W]$(__git_ps1)\$ '
fi

#pecoの設定
export HISTCONTROL="ignoredups"
peco-history() {
    local NUM=$(history | wc -l)
    local FIRST=$((-1*(NUM-1)))

    if [ $FIRST -eq 0 ] ; then
        history -d $((HISTCMD-1))
        echo "No history" >&2
        return
    fi

    local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

    if [ -n "$CMD" ] ; then
        history -s $CMD

        if type osascript > /dev/null 2>&1 ; then
            (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
        fi
    else
        history -d $((HISTCMD-1))
    fi
}
bind -x '"\C-r":peco-history'
