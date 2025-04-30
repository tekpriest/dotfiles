# vim: filetype=sh
#-------------------------------------------

# homebrew setup
if [[ $(uname -p) == "arm" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)" # M1 Mac
else
  eval "$(/usr/local/bin/brew shellenv)" # Intel Mac
fi
