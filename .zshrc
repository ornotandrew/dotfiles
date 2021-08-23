# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wraithy"

export NVM_LAZY_LOAD="true"
plugins=(zsh-nvm fancy-ctrl-z zsh-syntax-highlighting gitfast zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

ZSH_FILES=$HOME/.config/zsh

source $ZSH_FILES/aliases.zsh
source $ZSH_FILES/hashes.zsh
source $ZSH_FILES/completion.zsh
source $ZSH_FILES/base16_shell.zsh
source $ZSH_FILES/editing.zsh
source $ZSH_FILES/functions.zsh
source $ZSH_FILES/history.zsh
source $ZSH_FILES/3rd_party.zsh

# locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Make sure any script-local changes to path are exported
export PATH

