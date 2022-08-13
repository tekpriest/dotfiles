# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
HIST_STAMPS="yyyy-mm-dd"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-z
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

autoload -U compinit && compinit

[ -f ~/.zsh/functions.sh ] && source ~/.zsh/functions.sh
[ -f ~/.zsh/aliases.sh ] && source ~/.zsh/aliases.sh

# exports
export LOCAL_BIN=$HOME/.local/bin/
export PATH=$PATH:$LOCAL_BIN

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/usr/local/sbin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

# ZIG
export PATH=$PATH:~/.local/bin/zig

# Java
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export JDTLS_HOME=$HOME/.local/bin/jdtls
export WORKSPACE=$HOME/Code

# C
export LD_LIBRARY_PATH="/Library/Developer/CommandLineTools/usr/lib/:$LD_LIBRARY_PATH"

# GO
export GOBIN=$HOME/go/bin

# Flutter
export FLUTTER_BIN=$HOME/.local/bin/flutter/bin
export PATH="$PATH:$FLUTTER_BIN"
export SDK_ROOT=$HOME/Android/cmdline-tools/tools/bin
export PATH="$PATH:$SDK_ROOT"
export PATH=$PATH:$HOME/Android/platform-tools:$HOME/Android/emulator:$HOME/Android/build-tools/30.0.0

