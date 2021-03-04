# Defined in /Users/maciek/.config/fish/alias.fish @ line 185
function tk --description 'tmux kill session[s]'
	for session in $argv
		tmux kill-session -t $session
	end
end
