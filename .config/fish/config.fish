# bobthefish conf
set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_show_exit_status no
set -g theme_color_scheme base16-light

function sudo!!
	eval sudo $history[1]
end

# match all ~/.gem/ruby/[version]/bin paths
set -gx PATH $PATH (find ~/.gem/ruby -type d -regex ".+\.gem/ruby/[^/]+/bin")

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set NPM_PACKAGES "$HOME/.npm"
set -x PATH $NPM_PACKAGES/bin $PATH

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
