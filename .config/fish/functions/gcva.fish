function gcva --wraps='git commit --amend -n -m'
	if test -n "$argv"
		git commit --amend -nm "$argv"
	else
		git commit --amend -n
	end
end
