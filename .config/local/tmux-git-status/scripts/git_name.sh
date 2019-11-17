#!/usr/bin/env bash
set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

main() {
	if in_git_repo; then
		remote=`git config --get remote.origin.url`
		name=`basename -s .git $remote`
		echo "#[fg=blue]$name"
	fi
}
main
