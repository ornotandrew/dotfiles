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

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

# go
export GOBIN="/Users/andrew/.local/bin/"

# dotnet
# dotnet_root="/usr/local/share/dotnet/x64"
# path=($dotnet_root $path)
# export DOTNET_ROOT=$dotnet_root
