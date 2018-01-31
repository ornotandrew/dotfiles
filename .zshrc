# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"
plugins=(kubectl docker docker-compose mercurial virtualenvwrapper fancy-ctrl-z zmv zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Path
path+="/usr/local/sbin"
path+="/usr/local/bin"
path+="/usr/sbin"
path+="/usr/bin"
path+="/sbin"
path+="/bin"
path+="$HOME/.local/bin"
path+="$HOME/tools/google-cloud-sdk/bin"
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
alias k="kubectl"
alias vol="pactl set-sink-volume @DEFAULT_SINK@"
alias vim="nvim"
alias clip="xclip -sel clip"
alias y="yarn"
hash -d nngo="/home/andrew/go/src/bitbucket.org/nomanini"

# Completion
zstyle ':completion:*' users andrew root

# FZF bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_default-dark

# neovim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# virtualenvwrapper
export WORKON_HOME=~/venv
export LC_CTYPE=en_ZA.UTF-8

# Google cloud sdk
GCLOUD_SDK="$HOME/tools/google-cloud-sdk"
if [ -d $GCLOUD_SDK ]; then
    source $GCLOUD_SDK/completion.zsh.inc; # enables shell completion
fi

# Let vim be the MANPAGER
export MANPAGER="vim -c 'set ft=man' -"

# Golang things
export GOROOT=/usr/local/go
export GOPATH=~/go
path+=$GOPATH/bin/
path+=$GOROOT/bin/
export PATH

export XDG_CONFIG_HOME=~/.config

# Scripts for gcloud and shell
# ============================
dev() {
    kubectl config use-context gke_nomanini-dashboard_us-central1-a_dev
    export GCLOUD_ENV=dev
}

prod() {
    kubectl config use-context gke_nomanini-dashboard_us-central1-a_prod
    export GCLOUD_ENV=dev
}

kpatch() {
    kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
}
