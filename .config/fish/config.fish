set -x LC_ALL en_US.UTF-8

# Disable directory shortening for prompt_pwd
set fish_prompt_pwd_dir_length 0

# source ~/.config/fish/alias.fish
source ~/.config/fish/colors.fish

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f ~/.config/fish/env.fish ]; and source ~/.config/fish/env.fish

set -gx EDITOR vim

function _path
	set -gx PATH $argv $PATH
end

# match all ~/.gem/ruby/[version]/bin paths
# _path (find ~/.gem/ruby -type d -regex ".+\.gem/ruby/[^/]+/bin")

_path "/usr/local/sbin"

# rust cargo path
_path "$HOME/.cargo/bin"

# n - node version manager
set N_PATH "$HOME/.n"
set -gx N_PREFIX $N_PATH
_path "$N_PATH/bin"

# npm global packages
_path "$HOME/.npm/bin"

# go
set --universal -x GOPATH "$HOME/dev/go"

if not test -d $GOPATH
	echo $GOPATH
	mkdir -p $GOPATH
end

# fzf
set -gx FZF_DEFAULT_COMMAND "ag --hidden --silent --ignore .git -g ''"
set -gx FZF_CTRL_T_COMMAND "ag --hidden --silent --ignore .git -g ''"

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

if type -q direnv
	eval (direnv hook fish)
end

fish_ssh_agent

set -x GPG_TTY (tty)
