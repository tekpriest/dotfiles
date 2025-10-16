# vim: filetype=sh

CONFIGS=(
	aliasses
  completion
  docs_man
  git_github
  load_plugins
)

[[ "$DOSTYPE" =~ "darwin" ]] && CONFIGS+=(mac_specific)

for filename in "${CONFIGS[@]}"; do
	# shellcheck disable=1090
	source "$ZDOTDIR/config/$filename.zsh"
done
