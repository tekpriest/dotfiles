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

setopt EXTENDED_HISTORY
setopt autocd extendedglob
unsetopt beep

source $ZSH/oh-my-zsh.sh

# asdf
. /opt/asdf-vm/asdf.sh

# aliases
alias e="NVIM_APPNAME=tpde nvim"


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
export T_SESSION_NAME_INCLUDE_PARENT=true

# sources
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#plugins
plugins=(git)

# misc
if [ "$(command -v bat)" ]; then
 unalias -m 'cat'
 alias cat='bat -pp --theme=Nord'
fi

eval "$(zoxide init zsh)"
