# this file is not used directly, instead it generates functions
# for ~/.config/fish/functions/ that are used instead of
# sourcing `alias` directly for performance reasons.
# use `cas` to source this file.

# clear out all generated functions, hopefully skipping
# everything not placed there by this file (including fzf's
# function which is of `find`'s `-type` `l` for link)
rm (find $HOME/.config/fish/functions -type f -not -name 'fish_*')

# brew
# ====

alias -s ecc "echo ectoplasm"
alias -s b "brew"
alias -s bcd "brew cask doctor"
alias -s bch "brew cask help"
alias -s bci "brew cask install"
alias -s bcin "brew cask info"
alias -s bcl "brew cask list"
alias -s bcr "brew cask reinstall"
alias -s bcrm "brew cask uninstall"
alias -s bcup "brew cask upgrade"
alias -s bd "brew doctor"
alias -s bh "brew help"
alias -s bi "brew install"
alias -s bin "brew info"
alias -s bl "brew list"
alias -s br "brew reinstall"
alias -s brm "brew uninstall"
alias -s bs "brew search"
alias -s bt "brew tap"
alias -s bup "brew upgrade"
alias -s but "brew untap"

# config
# ======

alias -s ca "vim ~/.config/fish/generate-functions.fish"
alias -s cas "source ~/.config/fish/generate-functions.fish"
alias -s cf "vim ~/.config/fish/config.fish"
alias -s ch "vim ~/.hammerspoon/init.lua"
alias -s cha "vim ~/.hammerspoon/hyper-apps.lua"
alias -s ck "vim ~/.config/kitty/kitty.conf"
alias -s ckr "vim ~/.config/karabiner.edn"
alias -s ct "vim ~/.tmux.conf"
alias -s ctt "vim ~/.tmux.theme"
alias -s cv "vim ~/.vim/vimrc"

# fish
# ====

alias -s fns 'functions'
alias -s fsa 'source ~/.config/fish/generate-functions.fish'
alias -s fsc 'source ~/.config/fish/config.fish'

# git
# ===

alias -s ga "git add"
alias -s gaa "git add --all"
alias -s gap "git add -p"
alias -s gau "git add -u"
alias -s gapp "git apply"
alias -s gb "git branch"
alias -s gbr "git browse"

function gc --wraps "git commit -m"
	if test -n "$argv"
		git commit -m "$argv"
	else
		git commit
	end
end
funcsave gc

function gcv --wraps "git commit --no-verify -m"
	if test -n "$argv"
		git commit -n -m "$argv"
	else
		git commit -n
	end
end
funcsave gcv

function gca --wraps "git commit --amend -m"
	if test -n "$argv"
		git commit --amend -m "$argv"
	else
		git commit --amend
	end
end
funcsave gca

function gcva --wraps "git commit --amend -n -m"
	if test -n "$argv"
		git commit --amend -nm "$argv"
	else
		git commit --amend -n
	end
end
funcsave gcva

alias -s gcvan "git commit --amend -n --no-edit"

function gcal --wraps "git commit --all -m"
	if test -n "$argv"
		git commit --all -m "$argv"
	else
		git commit --all
	end
end
funcsave gcal

alias -s g "git"
alias -s gcan "git commit --amend --no-edit"
alias -s gck "git checkout"
alias -s gcl "git clone"
alias -s gd "git diff"
alias -s gdc "git diff --cached"
alias -s gf "git fetch"
alias -s gi "git init"
alias -s gl "git log"
alias -s gl1 "git log -n 1"
alias -s glg "git log --color=always --format=oneline --abbrev-commit --decorate | head"
alias -s gm "git merge"
alias -s gmff "git merge --ff-only"
alias -s gp "git push"
alias -s gpf "git push --force"
alias -s gpl "git pull"
alias -s gpu "git pull"
alias -s gpu "git push -u origin master"
alias -s gr "git reset"
alias -s grb "git rebase"
alias -s grba "git rebase --abort"
alias -s grbc "git rebase --continue"
alias -s grl "git reflog"
alias -s grm "git rm"
alias -s gs "git status"
alias -s gsuba "git submodule add"
alias -s gsubdi "git submodule deinit"
alias -s gsubi "git submodule init"
alias -s gsubu "git submodule update"
alias -s gsubur "git submodule update --recursive --remote"

function git --description "Alias for hub, which wraps git to provide extra functionality with GitHub."
	hub $argv
end
funcsave git

# npm
# ===

alias -s ndi "npm install -D"
alias -s ngi "npm install -g"
alias -s ngin "npm info -g"
alias -s nglg "npm list -g"
alias -s ngrm "npm uninstall -g"
alias -s ni "npm install"
alias -s nid "npm install --save-dev"
alias -s nin "npm info"
alias -s nls "npm list"
alias -s nr "npm run"
alias -s nrb "npm rebuild"
alias -s nrbf "npm rebuild --force"
alias -s nrm "npm uninstall"
alias -s ns "npm start"
alias -s nt "npm test"

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
funcsave t

function tk --description "tmux kill session[s]"
	for session in $argv
		tmux kill-session -t $session
	end
end
funcsave tk

# mac
# ===

alias -s md 'macdown'

function ding --description "Show a notification"
	set st $status

	set desc "$_ - $PWD"

	set title "Ding!"
	if test -n "$argv"
		set title "$argv"
	end

	set sound "glass"
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
funcsave ding

function _prefix_url_with_http
	set res $argv

	if test -n "$argv"
		if not string match 'http*://*' $res
			set res "http://"$res
		end
	end

	echo $res
end
funcsave _prefix_url_with_http

function safari --description 'Open Safari.app'
	open -a 'safari' (_prefix_url_with_http $argv)
end
funcsave safari

function firefox --description 'Open Firefox.app'
	open -a 'firefox' (_prefix_url_with_http $argv)
end
funcsave firefox

function chrome --description 'Open Google Chrome.app'
	open -a 'google chrome' (_prefix_url_with_http $argv)
end
funcsave chrome

function proxy --description 'Toggle system proxy'
	networksetup -setwebproxystate Wi-Fi $argv
	networksetup -setsecurewebproxystate Wi-Fi $argv
end
funcsave proxy

# bitwarden
# ===

function bwu --description 'Unlock Bitwarden vault'
	set -gx BW_SESSION (bw unlock --raw)
end
funcsave bwu

# local files
# ===

alias -s chromel 'open -a "google chrome"'
alias -s firefoxl 'open -a firefox'
alias -s safaril 'open -a safari'

# overrides
# ===

function alias_if_exists
	if type -q $argv[2]
		if test -n "$argv[3]"
			alias -s $argv[1] $argv[3]
		else
			alias -s $argv[1] $argv[2]
		end
	end
end

alias_if_exists cat bat
alias_if_exists ls exa 'exa -x --sort type'
alias_if_exists ls1 exa 'exa -1 --sort type'
alias_if_exists lsa exa 'exa -ax --sort type'
alias_if_exists lsa1 exa 'exa -a1 --sort type'
alias_if_exists ping prettyping

# misc
# ====

alias -s chx 'chmod +x'
alias -s d 'docker'
alias -s dc 'docker-compose'
alias -s how 'howdoi'
alias -s hows 'howdoi -n 5'
alias -s ld 'lazydocker'
alias -s lg 'lazygit'
alias -s orange '~/dev/scripts/orange/index.js'
alias -s qmv 'qmv --options=swap,indicator1="dest: ",indicator2="src: "'

function mkd --description 'Make directory and cd'
	mkdir $argv
	cd $argv[1]
end
funcsave mkd

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
funcsave i

function o --description 'Search Obsidian vault' --wraps=v
	v ~/Documents/vet/$argv
end
funcsave o

alias -s f 'ag -g'
alias -s mkdir 'mkdir -p'
alias -s nd 'nextd'
alias -s p 'python'
alias -s p2 'python2'
alias -s p3 'python3'
alias -s pd 'prevd'

function prod -a mode --description 'productivotivoti mode'
	set apps Mail Discord Caprine Skype Telegram Messages

	for app in $apps
		if test "$mode" = "on"
			osascript -e "quit app \"$app\"" &
		else if test "$mode" = "off"
			open -gja "$app" &
		end
	end
end
funcsave prod

alias -s r 'ag'
alias -s v 'vim'
alias -s vf 'vim (fzf)'
alias -s vim 'nvim'

function sudo!!
	eval sudo $history[1]
end
funcsave sudo!!

alias -s flushdns "sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
