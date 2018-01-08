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

function git --description "Alias for hub, which wraps git to provide extra functionality with GitHub."
    hub $argv
end

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

# mac
function ding --description "Show a notification"
    set st $status

    set desc "$_ - $PWD"

    set title "Ding!"
    if test -n "$argv"
	set title "$argv"
    end

    set sound "hero"
    # play scary sound if last cmd errored
    if test ! $st -eq 0
	set sound "sosumi"
	set err "Error ($st) - "
    end

    switch (uname)
	case Darwin
	    /usr/bin/osascript -e "display notification \"$desc\" with title \"$err$title\" sound name \"$sound\""
    end
end
