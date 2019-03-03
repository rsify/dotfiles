source ~/.config/fish/alias.fish
source ~/.config/fish/colors.fish

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f ~/.config/fish/env.fish ]; and source ~/.config/fish/env.fish

set -g EDITOR vim

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

# go
set --universal -x GOPATH "$HOME/dev/go"

if not test -d $GOPATH
	echo $GOPATH
	mkdir -p $GOPATH
end

# fzf
set -gx FZF_DEFAULT_COMMAND "ag --hidden --ignore .git -g ''"
set -gx FZF_CTRL_T_COMMAND "ag --hidden --ignore .git -g ''"

# binds
function __bind_functions
	set val (eval echo (commandline -t))

	printf "\n"
	functions $val
	printf "\n"

	commandline -f repaint
end

function fish_user_key_bindings
	bind \ea __bind_functions
	fzf_key_bindings
end
