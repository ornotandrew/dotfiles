# nvm
export NVM_DIR="$HOME/.config/nvm"
# TODO: make this happen when nvm is lazy loaded
export NODE_PATH="/Users/andrew/.config/nvm/versions/node/v16.9.1/lib/node_modules"
path+="/Users/andrew/.config/nvm/versions/node/v16.9.1/bin/"


# FZF bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_TMUX_OPTS='-d 40%'

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# OpenBlas
export LDFLAGS="$LDFLAGS -L/usr/local/opt/openblas/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openblas/include"
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig"

# Zlib
export LDFLAGS="$LDFLAGS -L/usr/local/opt/zlib/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/zlib/include"

# golang
path+="/Users/andrew/go/bin/"

# gsed (macOS)
path=("/usr/local/opt/gnu-sed/libexec/gnubin" $path)

# JAVA
export JAVA_HOME=$(/usr/libexec/java_home)

# Android SDK
export ANDROID_HOME=/usr/local/share/android-sdk

# Ruby
path=("/usr/local/opt/ruby/bin" $path)
