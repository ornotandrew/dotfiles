export ZSH=/home/andrew/.oh-my-zsh

ZSH_THEME="wraithy"

plugins=(git docker mercurial zsh-syntax-highlighting)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin"
fpath=($ZSH/custom/plugins/zsh-completions/src $fpath)

source $ZSH/oh-my-zsh.sh

# Aliases
alias please='sudo $(fc -ln -1)'
alias svim="sudo -E vim"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"
alias update="sudo apt-get update"
alias upgrade="sudo apt-get upgrade"
alias vim="echo Use nvim."
alias g="git"
alias hpu="hg pull && hg update"

# Fancy suspend
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# FZF bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
source '/home/andrew/code/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/home/andrew/code/google-cloud-sdk/completion.zsh.inc'
