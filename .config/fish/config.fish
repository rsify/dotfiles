set --export LC_ALL en_US.UTF-8

# disable directory shortening for prompt_pwd (`man prompt_pwd`)
set fish_prompt_pwd_dir_length 0

# sources
source ~/.config/fish/colors.fish
source ~/.config/fish/complete.fish

if test -f /opt/homebrew/share/autojump/autojump.fish
	source /opt/homebrew/share/autojump/autojump.fish
end

# vars
set --export EDITOR nvim
set --export N_PREFIX "$HOME/.n" # n
set --export GOPATH "$HOME/.go"
set --export FZF_DEFAULT_COMMAND "ag --hidden --silent --ignore .git -g ''"
set --export FZF_CTRL_T_COMMAND "ag --hidden --silent --ignore .git -g ''"

function _path
	set --export PATH $argv $PATH
end

# paths
_path /opt/homebrew/bin
_path "$HOME/.cargo/bin" # rust cargo path
_path "$N_PREFIX/bin" # n - node version manager
_path "$HOME/.npm/bin" # npm global packages
_path "$HOME/.deno/bin" # deno bin folder

if not test -d $GOPATH
	echo $GOPATH
	mkdir -p $GOPATH
end

# fzf binds
function __bind_functions
	set val (eval echo (commandline -t))

	printf "\n"
	functions $val
	printf "\n"

	commandline -f repaint
end

if type -q fzf_key_bindings
	function fish_user_key_bindings
		bind \ea __bind_functions
		fzf_key_bindings
	end
end

# start/attach to ssh-agent
fish_ssh_agent

# gpg crap, otherwise pinentry breyks
set --export GPG_TTY (tty)
