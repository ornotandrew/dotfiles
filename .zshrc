# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"
plugins=(docker docker-compose mercurial virtualenvwrapper fancy-ctrl-z zsh-syntax-highlighting)
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
path+="$HOME/tools/google_appengine"
export PATH

# Aliases
alias install="sudo apt install"
alias remove="sudo apt remove"
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias g="git"
alias hpu="hg pull && hg update"
alias hcm="hg commit -m Merge"
alias dc="docker-compose"
alias kc="kubectl"
alias vol="pactl set-sink-volume @DEFAULT_SINK@"

# Completion
zstyle ':completion:*' users andrew root

# FZF bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Google cloud sdk
GCLOUD_SDK="$HOME/tools/google-cloud-sdk"
if [ -d $GCLOUD_SDK ]; then
    source $GCLOUD_SDK/path.zsh.inc; # updates PATH
    source $GCLOUD_SDK/completion.zsh.inc; # enables shell completion
fi

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_default-dark

# neovim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# docker-compose
export COMPOSE_HTTP_TIMEOUT=600

# virtualenvwrapper
export WORKON_HOME=~/venv
export LC_CTYPE=en_ZA.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/andrew/tools/google-cloud-sdk/path.zsh.inc ]; then
  source '/home/andrew/tools/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/andrew/tools/google-cloud-sdk/completion.zsh.inc ]; then
  source '/home/andrew/tools/google-cloud-sdk/completion.zsh.inc'
fi


# Let vim be the MANPAGER
export MANPAGER="vim -c 'set ft=man' -"
