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
