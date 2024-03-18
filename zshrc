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

# source $ZSH/oh-my-zsh.sh
# source ~/.config/zsh/plugins/magic_dashboard.zsh
# source ~/.config/zsh/plugins/wezterm_semantic_prompts.zsh
# [[ "$TERM_PROGRAM" == "WezTerm" ]] && source "$ZDOTDIR/plugins/wezterm_semantic_prompts.zsh"

# asdf
source "$HOME/.asdf/asdf.sh"

# z
source "/opt/homebrew/etc/profile.d/z.sh"

# sources
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.config/zsh/config/aliases.zsh ] && source $HOME/.config/zsh/config/aliases.zsh
# [ -f ~/.config/zsh/config/completion.zsh ] && source ~/.config/zsh/config/completion.zsh
[ -f $HOME/.config/zsh/config/load_plugins.zsh ] && source $HOME/.config/zsh/config/load_plugins.zsh

export GOBIN=$(go env GOPATH)/bin

#plugins
# plugins=(git tmux)

# misc
if [ "$(command -v bat)" ]; then
	unalias -m 'cat'
	alias cat='bat -pp --theme=Nord'
fi

# mkcd is equivalent to takedir
mkcd() {
	mkdir -p $@ && cd ${@:$#}
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# for pop
export POP_SMTP_HOST=smtp.gmail.com
export POP_SMTP_PORT=587
export POP_SMTP_USERNAME=mikkysam52@gmail.com
export POP_SMTP_PASSWORD=Denigma@me123.
export POP_FROM=${POP_SMTP_USERNAME}
export POP_SIGNATURE="Sent from the command line"

# # zoxide
eval "$(zoxide init zsh)"

# vim: filetype=sh
