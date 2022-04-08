function gca --wraps='git commit --amend -m'
	if test -n "$argv"
		git commit --amend -m "$argv"
	else
		git commit --amend
	end
end
