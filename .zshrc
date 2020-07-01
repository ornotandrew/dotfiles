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
path+="$HOME/.local/bin"
path+="$HOME/tools/google-cloud-sdk/bin"
path+="/snap/bin"
path+="$HOME/.yarn/bin"
path+="$HOME/.config/yarn/global/node_modules/.bin"
path+="/usr/local/opt/mysql-client/bin"
path+="/usr/local/sbin"
path+="/usr/local/bin"
path+="/usr/sbin"
path+="/usr/bin"
path+="/sbin"
path+="/bin"
export PATH

# Aliases
alias ls='LC_COLLATE=C ls -h --group-directories-first --color=auto'
alias dc="docker-compose"
alias k="kubectl"
alias clip="xclip -sel c"
alias y="yarn"
alias sudo="sudo " # expand aliases when using sudo
alias -g vim="nvim"

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
export VIRTUALENVWRAPPER_PYTHON=`which python3`
source /usr/local/bin/virtualenvwrapper_lazy.sh 2>/dev/null

# locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Google cloud sdk
GCLOUD_SDK="$HOME/tools/google-cloud-sdk"
if [ -d $GCLOUD_SDK ]; then
    source $GCLOUD_SDK/completion.zsh.inc; # enables shell completion
fi

# Let vim be the MANPAGER
export MANPAGER="nvim -c 'set ft=man ts=8 nolist nomod noma nonu' -"

export XDG_CONFIG_HOME=~/.config

# Scripts for gcloud and shell
# ============================
kpatch() {
    kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
}

# edit command in vim
export VISUAL=nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm

# dotnet
# export DOTNET_ROOT=/opt/dotnet
# path+="$DOTNET_ROOT"
path+="/opt/mssql-tools/bin"
export PATH
