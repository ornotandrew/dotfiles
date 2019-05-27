# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"
plugins=(docker docker-compose mercurial fancy-ctrl-z zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Lazy load bigger plugins
function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
}

# Path
path+="/usr/local/sbin"
path+="/usr/local/bin"
path+="/usr/sbin"
path+="/usr/bin"
path+="/sbin"
path+="/bin"
path+="$HOME/.local/bin"
path+="$HOME/tools/google-cloud-sdk/bin"
path+="/snap/bin"
path+="$HOME/.yarn/bin"
path+="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
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

# virtualenvwrapper
export WORKON_HOME=~/venv
export PROJECT_HOME=~/code
export LC_CTYPE=en_ZA.UTF-8
source virtualenvwrapper_lazy.sh 2>/dev/null

# Google cloud sdk
GCLOUD_SDK="$HOME/tools/google-cloud-sdk"
if [ -d $GCLOUD_SDK ]; then
    source $GCLOUD_SDK/completion.zsh.inc; # enables shell completion
fi

# Let vim be the MANPAGER
export MANPAGER="vim -c 'set ft=man' -"

# Golang things
export GO111MODULE=on
export GOROOT=~/.go
export GOPATH=~/go
path+=$GOPATH/bin/
path+=$GOROOT/bin/
export PATH

export XDG_CONFIG_HOME=~/.config

# Scripts for gcloud and shell
# ============================
dev() {
    kubectl config use-context gke_nomanini-dashboard_us-central1-a_dev
    tmux set-env -gu prod_warning
}

prod() {
    kubectl config use-context gke_nomanini-dashboard_us-central1-a_prod
    tmux set-env -g prod_warning '#[fg=colour232,bg=colour202] PROD '
}

kpatch() {
    kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
}

# edit command in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line
