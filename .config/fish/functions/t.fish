# Defined in /Users/maciek/.config/fish/alias.fish @ line 163
function t --description 'tmux swiss knife'
	if test -n "$argv"
		if tmux ls -F "#S" | grep -Fxq $argv -
			# if exists, attach
			tmux attach -t $argv
		else
			# if session doesn't exist, create it
			if test -d ~/dev/$argv
				tmux new -s "$argv" -c ~/dev/$argv
			else if test -d ~/work/projects/$argv
				tmux new -s "work/$argv" -c ~/work/projects/$argv
			else
				tmux new -s "$argv"
			end
		end
	else
		# no arguments, list sessions
		tmux ls
	end
end
