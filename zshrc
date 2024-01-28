# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
ZSH_TMUX_AUTOSTART=true

setopt EXTENDED_HISTORY
setopt autocd extendedglob
unsetopt beep

source $ZSH/oh-my-zsh.sh

# asdf
. "$HOME/.asdf/asdf.sh"

# z
. "/opt/homebrew/etc/profile.d/z.sh"

# paths
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
export tpde=$HOME/.config/tpde
export EDITOR=e
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export VISUAL=e
export BAT_THEME=Catppuccin-mocha
export FZF_DEFAULT_COMMAND="fd -H -E '.git'"
export FZF_CTRL_T_COMMAND=e
# export T_SESSION_NAME_INCLUDE_PARENT=true
export PATH=$PATH:$HOME/.config/emacs/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/bin/flutter/bin
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# sources
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#plugins
plugins=(git tmux)

# misc
if [ "$(command -v bat)" ]; then
 unalias -m 'cat'
 alias cat='bat -pp --theme=Nord'
fi

eval "$(zoxide init zsh)"

# aliases
alias e="NVIM_APPNAME=tpde nvim"
alias l='ls -lFh'
alias la='ls -lAFh'
alias lr='ls -tRFh'
alias lt='ls -ltFh'
alias ll='ls -l'
alias ldot='ls -ld .*'
alias grep='ggrep'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias h='history'
alias which='type -a'
alias edit='nvim'
alias tmux='tmux -2'
alias s="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"
alias ln='ln -sfn'
alias curl='curl -L'
alias i='iex'
alias sqlite='sqlite3'
alias dud='du -d 1 -h'
alias ff='find . -type f -name'
