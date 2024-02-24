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
source ~/.config/zsh/plugins/magic_dashboard.zsh
# source ~/.config/zsh/plugins/wezterm_semantic_prompts.zsh
# [[ "$TERM_PROGRAM" == "WezTerm" ]] && source "$ZDOTDIR/plugins/wezterm_semantic_prompts.zsh"


# asdf
. "$HOME/.asdf/asdf.sh"

# z
. "/opt/homebrew/etc/profile.d/z.sh"

# sources
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.config/zsh/config/aliases.zsh ] && source ~/.config/zsh/config/aliases.zsh
# [ -f ~/.config/zsh/config/completion.zsh ] && source ~/.config/zsh/config/completion.zsh
[ -f ~/.config/zsh/config/load_plugins.zsh ] && source ~/.config/zsh/config/load_plugins.zsh

#plugins
plugins=(git tmux)

# misc
if [ "$(command -v bat)" ]; then
 unalias -m 'cat'
 alias cat='bat -pp --theme=Nord'
fi


# # zoxide
# eval "$(zoxide init zsh)"
