# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"

plugins=(fancy-ctrl-z zsh-syntax-highlighting gitfast)

source $ZSH/oh-my-zsh.sh

ZSH_FILES=$HOME/.config/zsh

source $ZSH_FILES/aliases.zsh
source $ZSH_FILES/hashes.zsh
source $ZSH_FILES/completion.zsh
source $ZSH_FILES/editing.zsh
source $ZSH_FILES/functions.zsh
source $ZSH_FILES/history.zsh
source $ZSH_FILES/3rd_party.zsh
[ -f ~/.secrets.sh ] && source ~/.secrets.sh

# locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# colors
export TERM=xterm-24bit

# Make sure any script-local changes to path are exported
export PATH
source /Users/andrew/.commonsh

. "$HOME/.local/bin/env"

# Added by Windsurf
export PATH="/Users/andrew/.codeium/windsurf/bin:$PATH"
