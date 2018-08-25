# if not in a tmux session
if test -z "$TMUX"
	set -gx TERM xterm-256color
end

source ~/.config/fish/alias.fish
source ~/.config/fish/colors.fish

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f ~/.config/fish/env.fish ]; and source ~/.config/fish/env.fish

set -g EDITOR vim

# iterm integration
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

function _path
	set -gx PATH $PATH $argv
end

# match all ~/.gem/ruby/[version]/bin paths
_path (find ~/.gem/ruby -type d -regex ".+\.gem/ruby/[^/]+/bin")

# npm global packages
_path "$HOME/.npm/bin"

_path "/usr/local/sbin"

# rust cargo path
_path "$HOME/.cargo/bin"

set -gx FZF_DEFAULT_COMMAND "ag --hidden --ignore .git -g ''"

function __bind_functions
	set val (eval echo (commandline -t))

	printf "\n"
	functions $val
	printf "\n"

	commandline -f repaint
end

function fish_user_key_bindings
	bind \ea __bind_functions
end
