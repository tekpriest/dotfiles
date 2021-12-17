########## EXPORTS ################
export ZSH="/Users/$USER/.oh-my-zsh"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export GIT_EDITOR="vim"
export VISUAL="vim"
export EDITOR="vim"
export DISABLE_AUTO_TITLE='true'
export PATH=$HOME/.local/bin:$PATH
export TERM=xterm-256color
# Golang #
export GOPATH="$(go env GOPATH)"
export PATH=$PATH:$GOPATH/bin
# Homebrew shinanigans #
export PATH="/usr/local/opt/qt@5/bin:$PATH"
export PATH="/usr/local/opt/qt5/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt@5/lib"
export CPPFLAGS="-I/usr/local/opt/qt@5/include"
export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"
# Flutter #
export PATH=$PATH:$HOME/.local/bin/flutter/bin
export PATH=$PATH:$HOME/.local/bin/android-sdk/cmdline-tools/5.0
export PATH=$PATH:$HOME/.local/bin/android-sdk/cmdline-tools/5.0/bin
export PATH=$PATH:$HOME/.local/bin/android-sdk/platform-tools
export ANDROID_HOME=$HOME/.local/bin/android-sdk
export ANDROID_SDK_ROOT=$HOME/.local/bin/android-sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
# Added by Amplify CLI binary installer #
export PATH="$HOME/.amplify/bin:$PATH"
# LuaLSP #
export PATH="$PATH:$HOME/.local/bin/lua-language-server/bin/macOS"
# Mono #
export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin/"
# Apiary #
APIARY_API_KEY="4dc74db63492eeb1fc8a721bce2b0b9b"

setopt EXTENDED_HISTORY

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE='true'
CASE_SENSITIVE='false'
COMPLETION_WAITING_DOTS='true'
ZSH_TMUX_AUTOSTART=true
HIST_STAMPS='yyyy-mm-dd'
DISABLE_MAGIC_FUNCTIONS=true


plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  ssh-agent
  git
  npm
  node
  brew
)

source $ZSH/oh-my-zsh.sh

# brew install pure
autoload -U promptinit; promptinit
prompt pure

function time-zsh() {
  for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
}
function time-zsh-plugins() {
  # brew install coreutils
  for plugin ($plugins); do
    timer=$(($(gdate +%s%0N)/1000000))
    if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
      source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
    elif [ $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
      source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    fi
    now=$(($(gdate +%s%0N)/1000000))
    elapsed=$(($now-$timer))
    echo $elapsed":" $plugin
  done
}

########### ALIASES ##############
alias ls="exa"
alias ll="exa --long --header --git --icons"
alias tree="ll --tree --level=4 -a -I=.git --git-ignore"
alias yw="yarn workspace"
alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias zshrcs="source ~/.zshrc"
alias vimrc="vim ~/.config/nvim"
alias tmuxrc="vim ~/.config/tmux.conf"
alias tmuxrcs="tmux source-file ~/.tmux.conf"
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias k='kubectl'

########### SOURCES ################
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
# Kubernetes #
complete -F __start_kubectl k
source <(kubectl completion zsh)


############ FUNCTIONS ################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

mkcd () {
  mkdir $1 && cd $_
}

############# MISC ##############
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
