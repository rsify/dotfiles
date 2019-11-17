# Defined in /Users/nikersify/.config/fish/alias.fish @ line 302
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
