# local binaries
path=("/Users/andrew/.local/bin/" $path)

# brew
path=("/opt/homebrew/bin" $path)

# FZF bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_TMUX_OPTS='-d 40%'

# gsed (macOS)
path=("/usr/local/opt/gnu-sed/libexec/gnubin" $path)

# Rust
export RUST_BACKTRACE=1
path=("/Users/andrew/.cargo/bin" $path)

# asdf
# source /opt/homebrew/opt/asdf/libexec/asdf.sh

# dotnet
# dotnet_root="/usr/local/share/dotnet/x64"
# path=($dotnet_root $path)
# export DOTNET_ROOT=$dotnet_root

# pnpm
export PNPM_HOME="/Users/andrew/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export NODE_OPTIONS=--no-deprecation
path=("/Users/andrew/Library/pnpm/nodejs/20.18.2/bin" $path)

# java
export JAVA_HOME="/opt/homebrew/opt/openjdk"
path=("$JAVA_HOME/bin" $path)

# libpq, for postgres utils
path=(/opt/homebrew/opt/libpq/bin $path)

# fzf
source <(fzf --zsh)

# rancher desktop
path=($HOME/.rd/bin $path)

# ollama
export OLLAMA_API_BASE=http://127.0.0.1:11434
