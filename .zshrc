export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="wraithy"

plugins=(git docker mercurial zsh-syntax-highlighting)

path+="/usr/local/sbin"
path+="/usr/local/bin"
path+="/usr/sbin"
path+="/usr/bin"
path+="/sbin"
path+="/bin"
path+="/usr/games"
path+="/usr/local/games"
path+="/usr/lib/jvm/java-8-oracle/bin"
path+="/usr/lib/jvm/java-8-oracle/db/bin"
path+="/usr/lib/jvm/java-8-oracle/jre/bin"
path+="$HOME/code/google_appengine"
path+="$HOME/code/venv/bin"
path+="$HOME/code/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin"
export PATH

fpath=($ZSH/custom/plugins/zsh-completions/src $fpath)

source $ZSH/oh-my-zsh.sh

# Aliases
alias please='sudo $(fc -ln -1)'
alias svim="sudo -E vim"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"
alias update="sudo apt-get update"
alias upgrade="sudo apt-get upgrade"
alias nvim="echo Use vim."
alias g="git"
alias hpu="hg pull && hg update"
alias hcm="hg commit -m Merge"

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
