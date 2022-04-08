function gcal --wraps='git commit --all -m'
	if test -n "$argv"
		git commit --all -m "$argv"
	else
		git commit --all
	end
end
