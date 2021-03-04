# Defined in /Users/maciek/.config/fish/alias.fish @ line 312
function i --description 'cd or cat'
	if test -n "$argv"
		set file "$argv"
	else
		set file "."
	end

	if test -d "$file"
		cd "$file"
	else
		cat "$file"
	end
end
