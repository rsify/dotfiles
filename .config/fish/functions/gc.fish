# Defined in /Users/maciek/.config/fish/alias.fish @ line 58
function gc --wraps='git commit -m'
	if test -n "$argv"
		git commit -m "$argv"
	else
		git commit
	end
end
