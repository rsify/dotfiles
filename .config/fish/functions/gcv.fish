function gcv --wraps='git commit --no-verify -m'
	if test -n "$argv"
		git commit -n -m "$argv"
	else
		git commit -n
	end
end
