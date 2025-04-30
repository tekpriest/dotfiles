# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

HISTFILE=~/.histfile
HISTSIZE=100000000
SAVEHIST=$HISTSIZE
# ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE='true'
CASE_SENSITIVE='false'
COMPLETION_WAITING_DOTS='true'
HIST_STAMPS='yyyy-mm-dd'
DISABLE_MAGIC_FUNCTIONS=true
COMPLETION_WAITING_DOTS="true"
# ZSH_TMUX_AUTOSTART=true

setopt EXTENDED_HISTORY
setopt autocd extendedglob
unsetopt beep

plugins=()

# exports
export BREW_PREFIX=$(brew --prefix)
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export GOBIN=/Users/tp/go/bin
export BUN_INSTALL="$HOME/.bun"
export GEM_HOME="$HOME/.gem"
export NVM_DIR="$HOME/.nvm"
export DEEPSEEK_API_KEY=sk-a03b86c2ff114c088114d03551ec55ec
export CFLAGS="-I$BREW_PREFIX/include"
export LDFLAGS="-L/$BREW_PREFIX/lib"
export CPATH="$BREW_PREFIX/include"
export LIBRARY_PATH="$BREW_PREFIX/lib"
export LD_LIBRARY_PATH="$BREW_PREFIX/lib"
export DENO_BIN="$HOME/.deno/bin"

# sources
# FZF
[ -f "$HOME"/.fzf.zsh ] && source "$HOME"/.fzf.zsh
# aliases
[ -f "$HOME"/.config/zsh/config/aliases.zsh ] && source "$HOME"/.config/zsh/config/aliases.zsh
# load plugins
[ -f "$HOME"/.config/zsh/config/load_plugins.zsh ] && source "$HOME"/.config/zsh/config/load_plugins.zsh
# z
[ -f "$BREW_PREFIX"/etc/profile.d/z.sh ] && source "$BREW_PREFIX"/etc/profile.d/z.sh
# bun completions
[ -s "$BUN_INSTALL"/_bun ] && source "$BUN_INSTALL"/_bun
# nvm
[ -s "$NVM_DIR"/nvm.sh ] && source "$NVM_DIR"/nvm.sh # This loads nvm
# deno
[ -s "$DENO_BIN"/env ] && . "$DENO_BIN"/env
# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/tp/.zsh/completions:"* ]]; then export FPATH="/Users/tp/.zsh/completions:$FPATH"; fi

# custom binaries
export PATH=$PATH:$HOME/.config/bin/
# doom emacs
export PATH=$PATH:$HOME/.config/emacs/bin
# rust
export PATH=$PATH:$HOME/.cargo/bin
# bun
export PATH="$BUN_INSTALL/bin:$PATH"
# asdf
export PATH="${ASDF_DATA_DIR:-$HOME}/.asdf/shims:$PATH"

if [[ -n $ZSH_EXECUTION_STRING ]]; then
	return
fi

# zoxide
eval "$(zoxide init zsh)"

# starship
eval "$(starship init zsh)"

# functions
# create and cd into dir
mkcd() {
	mkdir -p "$@" && cd "${@:$#}" || exit
}

# kill running ports
killport() {
	lsof -i TCP:"$1" | grep LISTEN | awk "{print $2}" | xargs kill -9
}

# get current ip in terminal
getip() {
	curl "https://ip.ecp.plus"
}

# vim: filetype=sh
