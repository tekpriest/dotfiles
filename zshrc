# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/x1k/.oh-my-zsh"
export EDITOR=nvim

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE='true'
CASE_SENSITIVE='false'
COMPLETION_WAITING_DOTS='true'
ZSH_TMUX_AUTOSTART=true
HIST_STAMPS='yyyy-mm-dd'
DISABLE_MAGIC_FUNCTIONS=true

plugins=(zsh-syntax-highlighting zsh-autosuggestions ssh-agent zsh-z)

source $ZSH/oh-my-zsh.sh


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

[ -f ~/.config/env.sh  ] && source ~/.config/env.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Functions
# Fuzzy search
fh() {
  eval $( ([-n "$ZSH_NAME"] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

mkcd () {
  mkdir $1 && cd $_
}

# Alias
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias zshconfig="nvim ~/.zshrc"
export PATH="/usr/local/sbin:$PATH"

source <(kubectl completion zsh)

alias k=kubectl
complete -F __start_kubectl k

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Python
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export WORKON_HOME=$HOME/.envs
export PROJECT_HOME=$HOME/Code
export PATH=$PATH:/usr/local/sbin
source /usr/local/bin/virtualenvwrapper.sh

export PATH=$PATH:$HOME/.composer/vendor/bin

# Golang
export GOPATH="$(go env GOPATH)"
export PATH=$PATH:$GOPATH/bin

# Local bin path
export BINPATH=$HOME/.local/bin/
export PATH=$PATH:$BINPATH

SAM_CLI_TELEMETRY=0

if [ "$(command -v bat)" ]; then
 unalias -m 'cat'
 alias cat='bat -pp --theme=Nord'
fi

# Homebrew shinanigans
export PATH="/usr/local/opt/qt@5/bin:$PATH"
export PATH="/usr/local/opt/qt5/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt@5/lib"
export CPPFLAGS="-I/usr/local/opt/qt@5/include"
export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

# LuaLSP
export PATH="$PATH:$HOME/.local/bin/lua-language-server/bin/macOS"

# Mono
export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin/"

# Dotnet
export PATH="$PATH:/Users/x1k/.dotnet/tools"

# Deno
fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u

# Starship
eval "$(starship init zsh)"

# Flutter
export ANDROID_SDK_ROOT=/Users/x1k/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT
export PATH=$PATH:$HOME/.local/bin/flutter/bin
export PATH=$PATH:/Users/x1k/Library/Android/sdk/cmdline-tools/latest/bin
export PATH=$PATH:/Users/x1k/Library/Android/sdk/cmdline-tools/latest
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# PNPM
# alias npm = pnpm
# alias npx = pnpx

# ISTIO
export PATH="$PATH:$HOME/.local/bin/istio/bin"
