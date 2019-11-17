# Defined in /Users/nikersify/.config/fish/alias.fish @ line 96
function gcal --wraps='git commit --all -m'
    if test -n "$argv"
		git commit --all -m "$argv"
	else
		git commit --all
	end
end
