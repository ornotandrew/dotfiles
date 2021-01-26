# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"

export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim')
export NVM_LAZY_LOAD="true"
plugins=(zsh-nvm fancy-ctrl-z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

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
alias ls='LC_COLLATE=C gls -h --group-directories-first --color=auto'
alias dc="docker-compose"
alias k="kubectl"
alias tf="terraform"
alias clip="pbcopy"
alias y="yarn"
alias sudo="sudo " # expand aliases when using sudo
alias -g vim="nvim"
alias sba="source env/bin/activate && [ -f env/vars.sh ] && source env/vars.sh"

# Completion
zstyle ':completion:*' users andrew root
autoload bashcompinit && bashcompinit

# FZF bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_TMUX_OPTS='-d 40%'

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_default-dark

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

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
function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
}

kpatch() {
    kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
}

pjq() {
    sed 's/'\''/"/g' | sed 's/None/null/g' | jq
}

urldecode() {
  echo -e "$(sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
}

# edit command in vim
export VISUAL=nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# nvm
export NVM_DIR="$HOME/.config/nvm"
# TODO: make this happen when nvm is lazy loaded
export NODE_PATH="/Users/andrew/.config/nvm/versions/node/v14.13.1/lib/node_modules"

# dotnet
# export DOTNET_ROOT=/opt/dotnet
# path+="$DOTNET_ROOT"
path+="/opt/mssql-tools/bin"
export PATH

# Blacklist certain things from getting into the history file
setopt histignorespace
export HISTORY_IGNORE="*--password*"
