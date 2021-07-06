# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"

export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim')
export NVM_LAZY_LOAD="true"
plugins=(zsh-nvm fancy-ctrl-z zsh-syntax-highlighting gitfast zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ls='LC_COLLATE=C gls -h --group-directories-first --color=auto'
alias dc="docker-compose"
alias k="kubectl"
alias tf="terraform"
alias clip="pbcopy"
alias sudo="sudo " # expand aliases when using sudo
alias -g vim="nvim"

# Hashes/working dir shortcuts
hash -d scripts=~/code/yield-scripts

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

# Let vim be in charge of shell-things
export MANPAGER="nvim -c 'set ft=man ts=8 nolist nomod noma nonu' -"
export EDITOR="nvim"
export VISUAL=nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# Scripts
kpatch() {
    kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
}

pjq() {
    sed 's/'\''/"/g' | sed 's/None/null/g' | jq
}

urldecode() {
  echo -e "$(sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
}

gch() {
  git checkout "$(git branch --all | sed 's/remotes\/origin\///' | sort -u | fzf | tr -d '[:space:]')"
}

sba() {
    source env/bin/activate
    [ -f env/vars.sh ] && source env/vars.sh
}

# nvm
export NVM_DIR="$HOME/.config/nvm"
# TODO: make this happen when nvm is lazy loaded
export NODE_PATH="/Users/andrew/.config/nvm/versions/node/v14.13.1/lib/node_modules"
path+="/Users/andrew/.config/nvm/versions/node/v14.13.1/bin/"


# OpenBlas
export LDFLAGS="-L/usr/local/opt/openblas/lib"
export CPPFLAGS="-I/usr/local/opt/openblas/include"
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig"

# Blacklist certain things from getting into the history file
setopt histignorespace
export HISTORY_IGNORE="*--password*"

# Make sure any script-local changes to path are exported
export PATH
