# git
alias ga "git add"
alias gap "git add -p"

function gc --wraps git --description "git commit -m"
	if test -n "$argv"
		git commit -m "$argv"
	else
		git commit
	end
end

function gca --wraps git --description "git commit --amend -m"
	if test -n "$argv"
		git commit --amend -m "$argv"
	else
		git commit --amend
	end
end

alias gcan "git commit --amend --no-edit"
alias gd "git diff"
alias gdc "git diff --cached"
alias gl "git log"
alias glg "git log --color=always --format=oneline --abbrev-commit --decorate | head"
alias gp "git push"
alias gpf "git push --force"
alias gr "git reset HEAD"
alias gs "git status"

# tmux
alias ta "tmux attach -t"
alias tk "tmux kill-session -t"
alias tls "tmux ls"

function tn --wraps tmux --description "tmux new"
	if test -n "$argv"
		tmux new -s "$argv"
	else
		tmux new -s (sort -R .config/misc/words | head -n 1)
	end
end
