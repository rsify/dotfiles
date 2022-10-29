set --export LC_ALL en_US.UTF-8

# disable directory shortening for prompt_pwd (`man prompt_pwd`)
set fish_prompt_pwd_dir_length 0

# sources
source ~/.config/fish/colors.fish
source ~/.config/fish/complete.fish

# https://github.com/gsamokovarov/jump
# `go install github.com/gsamokovarov/jump@latest`
~/.go/bin/jump shell fish | source

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
_path "$HOME/.yarn/bin"
_path "$HOME/.go/bin"
_path "$HOME/bin"

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

# gpg crap, otherwise pinentry breyks
set --export GPG_TTY (tty)

# less (including man) colors
# https://github.com/decors/fish-colored-man/blob/master/functions/man.fish
set -x LESS_TERMCAP_mb (set_color --bold red)
set -x LESS_TERMCAP_md (set_color --bold 5fafd7)
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
# set -x LESS_TERMCAP_so (set_color 949494) # includes search item & bottom bar
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (set_color --underline afafd7)

if test $hostname = 'ryrz'
	# test if in login shell
	if status is-login
		# test if length of $DISPLAY is non zero and
		# $XDG_VTNR (virtual terminal number, set by `pam_systemd`) is 1
		if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
			# -keeptty redirects the output from the X session into the Xorg log file. (source: https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login)
			# use `exec` to replace the login shell process with startx
			# (so as to prevent getting into the login shell just by killing X hopefully)
			exec startx -- -keeptty
		end
	end
end
