# Alias
alias l='ls -d .*'
alias ll='ls -lh'
if [ "`uname`" == "Darwin" ]; then
  # Mac OS
  alias ls='ls -GF'
  alias vim='/usr/local/Cellar/vim/7.4.1864_1/bin/vim'
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
  # Complement
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  source /usr/local/etc/bash_completion.d/git-completion.bash
else
  # Others
  alias ls='ls -GF --color=auto'
  . /usr/local/share/bash-completion/bash_completion
  source /usr/local/share/bash-completion/git-prompt.sh
  source /usr/local/share/bash-completion/git-completion.bash
fi

#alias ls='ls -GF'
alias la='ls -lA'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
alias vi='vim'
# alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias less='less -MN'
alias svim='sudo -E vim'

#export LSCOLORS=gxfxcxdxbxegedabagacad

function ssh() {
  if [[ -n $(printenv TMUX) ]]; then
    local window_name=$(tmux display -p '#{window_name}')
    # tmux rename-window -- "$@[-1]" # zsh specified
    tmux rename-window -- "${!#}" # for bash
    command ssh $@
    tmux rename-window $window_name
  else
    command ssh $@
  fi
}

# ssh-agent
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
    /tmp/*/agent.[0-9]*)
        ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    echo "no ssh-agent"
fi

function share_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999

# prompt
GIT_PS1_SHOWDIRTYSTATE=true
export PS1="\[\e[36m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[34m\]\w \[\e[0m\](\d \t)\n$ "
# export PS1="\[\e[36m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[34m\]\w \[\e[33m\]$(__git_ps1 [%s]) \[\e[0m\](\d \t)\n$ "
