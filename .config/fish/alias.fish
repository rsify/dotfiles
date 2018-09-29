# brew
# ====

alias b "brew"
alias bcd "brew cask doctor"
alias bch "brew cask help"
alias bci "brew cask install"
alias bcin "brew cask info"
alias bcl "brew cask list"
alias bcr "brew cask reinstall"
alias bcrm "brew cask uninstall"
alias bcs "brew cask search"
alias bcup "brew cask upgrade"
alias bd "brew doctor"
alias bh "brew help"
alias bi "brew install"
alias bin "brew info"
alias bl "brew list"
alias br "brew reinstall"
alias brm "brew uninstall"
alias bs "brew search"
alias bt "brew tap"
alias bup "brew upgrade"
alias but "brew untap"

# config
# ======

alias ca "vim ~/.config/fish/alias.fish"
alias cf "vim ~/.config/fish/config.fish"
alias ch "vim ~/.hammerspoon/init.lua"
alias cha "vim ~/.hammerspoon/hyper-apps.lua"
alias ck "vim ~/Library/Preferences/kitty/kitty.conf"
alias ckr "vim ~/.config/karabiner/karabiner.json"
alias ct "vim ~/.tmux.conf"
alias ctt "vim ~/.tmux.theme"
alias cv "vim ~/.vim/vimrc"

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
alias gapp "git apply"
alias gb "git branch"
alias gbr "git browse"

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

function gcal --wraps git --description "git commit --all -m"
	if test -n "$argv"
		git commit --all -m "$argv"
	else
		git commit --all
	end
end

alias gcan "git commit --amend --no-edit"
alias gck "git checkout"
alias gd "git diff"
alias gdc "git diff --cached"
alias gf "git fetch"
alias gi "git init"
alias gl "git log"
alias gl1 "git log -n 1"
alias glg "git log --color=always --format=oneline --abbrev-commit --decorate | head"
alias gm "git merge"
alias gp "git push"
alias gpf "git push --force"
alias gpu "git pull"
alias gpu "git push -u origin master"
alias gr "git reset"
alias grb "git rebase"
alias grl "git reflog"
alias grm "git rm"
alias gs "git status"
alias gsuba "git submodule add"
alias gsubdi "git submodule deinit"
alias gsubi "git submodule init"
alias gsubu "git submodule update"
alias gsubur "git submodule update --recursive --remote"

function git --description "Alias for hub, which wraps git to provide extra functionality with GitHub."
	hub $argv
end

# npm
# ===

alias ndi "npm install -D"
alias ngi "npm install -g"
alias ngin "npm info -g"
alias nglg "npm list -g"
alias ngrm "npm uninstall -g"
alias ni "npm install"
alias nid "npm install --save-dev"
alias nin "npm info"
alias nls "npm list"
alias nr "npm run"
alias nrb "npm rebuild"
alias nrbf "npm rebuild --force"
alias nrm "npm uninstall"
alias ns "npm start"
alias nt "npm test"

# tmux
# ====

function t --description "tmux swiss knife"
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

function tk --description "tmux kill session[s]"
	for session in $argv
		tmux kill-session -t $session
	end
end

complete --command t -xa "(tmux ls -F '#S')"
complete --command tk -xa "(tmux ls -F '#S')"

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
# ===
alias chromel 'open -a "google chrome"'
alias firefoxl 'open -a firefox'
alias safaril 'open -a safari'

# overrides
function _alias_if_exists
	if type -q $argv[1]
		alias $argv[1] $argv[2]
	end
end

_alias_if_exists cat bat
_alias_if_exists ls exa
_alias_if_exists stat gstat
_alias_if_exists ping prettyping

# misc
# ====

alias chx 'chmod +x'
alias how 'howdoi'
alias hows 'howdoi -n 5'

function mkd --description 'Make directory and cd'
	mkdir $argv
	cd $argv[1]
end

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

alias f 'ag -g'
alias ls1 'ls -1'
alias lsa 'ls -a'
alias lsa1 'ls -a1'
alias mkdir 'mkdir -p'
alias p 'python'
alias p2 'python2'
alias p3 'python3'
alias r 'ag'
alias v 'vim'
alias vf 'vim (fzf)'

function sudo!!
	eval sudo $history[1]
end

alias flushdns "sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
