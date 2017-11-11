# git
alias ga "git add"
alias gap "git add -p"

function gc --wraps git --description 'git commit -m'
	git commit -m "$argv"
end

function gca --wraps git --description 'git commit --amend -m'
	git commit --amend -m "$argv"
end

alias gcan "git commit --amend --no-edit"
alias gd "git diff"
alias gdc "git diff --cached"
alias gl "git log"
alias glg "git log --color=always --format=oneline --abbrev-commit --decorate | head"
alias gp "git push"
alias gr "git reset HEAD"
alias gs "git status"

# tmux
alias tn "tmux new"
alias tls "tmux ls"
