# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/x1k/.oh-my-zsh"
export EDITOR=vim

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
alias zshconfig="vim ~/.zshrc"
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

# Composer
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

# Flutter
export PATH=$PATH:$HOME/.local/bin/flutter/bin
export PATH=$PATH:$HOME/.local/bin/android-sdk/cmdline-tools/5.0
export PATH=$PATH:$HOME/.local/bin/android-sdk/cmdline-tools/5.0/bin
export PATH=$PATH:$HOME/.local/bin/android-sdk/platform-tools
export ANDROID_HOME=$HOME/.local/bin/android-sdk
export ANDROID_SDK_ROOT=$HOME/.local/bin/android-sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# android aliases

create_avd() {
  echo "no" | avdmanager --verbose create avd --force --name $1 --package "system-images;android-29;google_apis;x86_64" --tag "google_apis" --abi "x86_64"
}

run_avd() {
  emulator @$1 -no-boot-anim -netdelay none -no-snapshot -wipe-data -skin 1080x1920 &
}

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

# LuaLSP
export PATH="$PATH:$HOME/.local/bin/lua-language-server/bin/macOS"

# Mono
export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin/"
