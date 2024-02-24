# INFO leading space to ignore it in history due to `HIST_IGNORE_SPACE`
alias r=' exec zsh' # do not reload with source ~/.zshrc, https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reload-the-zshrc-file
alias cmd='command'

# INFO setting custom app director for my neovim config
alias e="NVIM_APPNAME=tpde nvim"

alias edit='nvim'

alias l='ls -lFh'
alias la='ls -lAFh'
alias lr='ls -tRFh'
alias lt='ls -ltFh'
alias ll='ls -l'
alias ldot='ls -ld .*'
alias ln='ln -sfnwi'


alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias rm='rm -I'

alias curl='curl -L --progress-bar'

alias grep='ggrep'
alias tmux='tmux -2'

alias s="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"
alias sqlite='sqlite3'
alias dud='du -d 1 -h'
alias ff='find . -type f -name'
alias nv='nvim'

alias fman='compgen -c | fzf | xargs man'
alias kpods="kubectl get -A --no-headers | fzf | awk '{print $2, $1}' | xargs -n 2 sh -c 'kubectl describe pod $0 -n $1'"
alias big_files='du -ah . | sort -hr | head -n 10'
alias delete_node_modules="find . -name 'node_modules' -type d |\
  xargs du -sh |\
  sort -hr |\
  fzf -m --header 'Select which ones to delete' --preview 'cat $(dirname {})/package.json'|\
  awk '{print $2}' |\
  xargs -r rm -rf \;"
alias elixir_deps_get="find . -mindepth 1 -maxdepth 1 -type d -exec sh -c '(cd {} && mix deps.get)' \;"
alias elixir_deps_update="find . -mindepth 1 -maxdepth 1 -type d -exec sh -c '(cd {} && mix deps.update --all)' \;"

function which { builtin which -a "$@" | bat --language=sh --wrap=character; } # colorized & showing all

#───────────────────────────────────────────────────────────────────────────────
# https://www.thorsten-hans.com/5-types-of-zsh-aliases

# GLOBAL ALIAS (to be used at the end, mostly)
alias -g G='| rg'
alias -g B='| bat'
alias -g N='| wc -l | tr -d " "' # count lines
alias -g L='| less'
alias -g J='| jless'
alias -g C='| pbcopy ; echo "Copied."' # copy
alias P='pbpaste'                      # paste

# highlights for them
ZSH_HIGHLIGHT_REGEXP+=(' G($| )' 'fg=magenta,bold')
ZSH_HIGHLIGHT_REGEXP+=(' C$' 'fg=magenta,bold')
ZSH_HIGHLIGHT_REGEXP+=(' B$' 'fg=magenta,bold')
ZSH_HIGHLIGHT_REGEXP+=(' N$' 'fg=magenta,bold')
ZSH_HIGHLIGHT_REGEXP+=(' L$' 'fg=magenta,bold')
ZSH_HIGHLIGHT_REGEXP+=(' J$' 'fg=magenta,bold')
ZSH_HIGHLIGHT_REGEXP+=('^P ' 'fg=magenta,bold')

#───────────────────────────────────────────────────────────────────────────────
