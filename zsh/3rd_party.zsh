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
  eval "$(pyenv init --path)"
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
path+="$ANDROID_HOME/tools/bin"

# Ruby
path=("/usr/local/opt/ruby/bin" $path)

# Python (pyenv)
path+="/Users/andrew/Library/Python/3.9/bin"
# pyenv doesn't respect pip.conf, so we need to export this variable
export PIP_EXTRA_INDEX_URL=$(cat ~/.config/pip/pip.conf | grep 'extra-index-url' | cut -d" " -f3)

# Pipenv
export PIPENV_VENV_IN_PROJECT=1

# Rust
export RUST_BACKTRACE=1

# OpenSSL
export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl@1.1/include"
