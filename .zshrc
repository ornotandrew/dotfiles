export ZSH=$HOME/.oh-my-zsh

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

# Google cloud sdk
GCLOUD_SDK="$HOME/code/google-cloud-sdk"
if [ -d $GCLOUD_SDK ]; then
    source $GCLOUD_SDK/path.zsh.inc; # updates PATH
    source $GCLOUD_SDK/completion.zsh.inc; # enables shell completion
fi
