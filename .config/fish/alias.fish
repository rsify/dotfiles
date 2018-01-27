# brew
# ====

alias b "brew"
alias bcd "brew cask doctor"
alias bch "brew cask help"
alias bci "brew cask info"
alias bcin "brew cask install"
alias bcl "brew cask list"
alias bcri "brew cask reinstall"
alias bcs "brew cask search"
alias bcu "brew cask upgrade"
alias bcun "brew cask uninstall"
alias bd "brew doctor"
alias bh "brew help"
alias bi "brew info"
alias bin "brew install"
alias bl "brew list"
alias bri "brew reinstall"
alias bs "brew search"
alias bt "brew tap"
alias bug "brew upgrade"
alias bun "brew uninstall"
alias bup "brew update"
alias but "brew untap"

# config
# ======

alias ca "vim ~/.config/fish/alias.fish"
alias cf "vim ~/.config/fish/config.fish"
alias ck "vim ~/Library/Preferences/kitty/kitty.conf"
alias cv "vim ~/.vim/vimrc"
alias ct "vim ~/.tmux.conf"
alias ctt "vim ~/.tmux.theme"

# fish
# ====

alias fns 'functions'
alias fsa 'source ~/.config/fish/alias.fish'
alias fsc 'source ~/.config/fish/config.fish'

# git
# ===

alias ga "git add"
alias gap "git add -p"
alias gau "git add -u"

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
alias grm "git rm"
alias gs "git status"
alias gsuba "git submodule add"
alias gsubi "git submodule init"
alias gsubdi "git submodule deinit"
alias gsubu "git submodule update"
alias gsubur "git submodule update --recursive --remote"

function git --description "Alias for hub, which wraps git to provide extra functionality with GitHub."
	hub $argv
end

# tmux
# ====

function ta --description "tmux attach"
	# functioned so it doesn't wrap tmux' default completions
	tmux attach -t $argv
end

alias tk "tmux kill-session -t"
alias tls "tmux ls"

function tn --description "tmux new"
	if test -n "$argv"
		# start session in ~/dev/<argv> if the dir exists
		if test -d ~/dev/$argv
			tmux new -s "$argv" -c ~/dev/$argv
		else
			tmux new -s "$argv"
		end
	else
		tmux new -s (sort -R .config/misc/words | head -n 1)
	end
end

complete --command ta -xa "(tmux ls -F '#S')"
complete --command tn -xa "(ls -1 ~/dev)"

# mac
# ===

alias md 'macdown'

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

function _prefix_url_with_http
	set res $argv

	if test -n "$argv"
		if not string match 'http*://*' $res
			set res "http://"$res
		end
	end

	echo $res
end

function safari --description 'Open Safari.app'
	open -a 'safari' (_prefix_url_with_http $argv)
end

function firefox --description 'Open Firefox.app'
	open -a 'firefox' (_prefix_url_with_http $argv)
end

function chrome --description 'Open Google Chrome.app'
	open -a 'google chrome' (_prefix_url_with_http $argv)
end

# local files
alias chromel 'open -a "google chrome"'
alias firefoxl 'open -a firefox'
alias safaril 'open -a safari'

# misc
# ====

alias chx 'chmod +x'
alias how 'howdoi'
alias hows 'howdoi -n 5'
alias ls1 'ls -1'
alias lsa 'ls -a'
alias mkdir 'mkdir -p'
alias v 'vim'

function sudo!!
	eval sudo $history[1]
end
