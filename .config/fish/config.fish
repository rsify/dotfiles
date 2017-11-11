. ~/.config/fish/alias.fish

# bobthefish conf
set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_show_exit_status no
set -g theme_color_scheme base16-light

function sudo!!
	eval sudo $history[1]
end

function _path
	set -gx PATH $PATH $argv
end

# iterm integration
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# match all ~/.gem/ruby/[version]/bin paths
_path (find ~/.gem/ruby -type d -regex ".+\.gem/ruby/[^/]+/bin")

# npm global packages
_path "$HOME/.npm/bin"

_path "/usr/local/sbin"

# rust cargo path
_path "$HOME/.cargo/bin"

set -gx FZF_DEFAULT_COMMAND "ag --hidden --ignore .git -g ''"
