# vim: filetype=sh

# INFO defines location of the zsh config
export ZDTODIR="$HOME/.config/zsh"
#-----------------------------------------------------------

# paths
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
export EDITOR=nvim
# export GOBIN=$(go env GOPATH)/bin
export VISUAL=e
export BAT_THEME=Catppuccin-mocha
export FZF_DEFAULT_COMMAND="fd -H -E '.git'"
export FZF_CTRL_T_COMMAND=e
# export T_SESSION_NAME_INCLUDE_PARENT=true
export PATH=$PATH:$HOME/go/bin
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH=$PATH:$HOME/Library/Python/3.9/bin

# NEOVIM
# so packages managed by mason are generally available
export PATH="$HOME/.local/share/nvim/mason/bin":$PATH
