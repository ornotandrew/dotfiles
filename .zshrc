# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"
plugins=(mercurial fasd fancy-ctrl-z zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Path
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
path+="$HOME/.local/bin"
path+="$HOME/code/google_appengine"
path+="$HOME/code/venv/nomanini/bin"
path+="$HOME/code/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin"
export PATH

# Aliases
alias please='sudo $(fc -ln -1)'
alias svim="sudo -E vim"
alias install="sudo apt install"
alias remove="sudo apt remove"
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias g="git"
alias hpu="hg pull && hg update"
alias hcm="hg commit -m Merge"
alias vpython="$HOME/code/venv/nomanini/bin/python"
alias vpip="$HOME/code/venv/nomanini/bin/pip"
alias lpython="$HOME/code/venv/loans/bin/python3"
alias lpip="$HOME/code/venv/loans/bin/pip3"
alias dc="docker-compose"
alias kc="kubectl"

# Completion
zstyle ':completion:*' users andrew root

# FZF bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Google cloud sdk
GCLOUD_SDK="$HOME/code/google-cloud-sdk"
if [ -d $GCLOUD_SDK ]; then
    source $GCLOUD_SDK/path.zsh.inc; # updates PATH
    source $GCLOUD_SDK/completion.zsh.inc; # enables shell completion
fi

# Base16 Shell
BASE16_SHELL="$HOME/code/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# neovim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# docker-compose
export COMPOSE_HTTP_TIMEOUT=600

# terminix
source /etc/profile.d/vte.sh
