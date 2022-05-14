# this file is not used in config.fish directly - instead it
# generates functions for ~/.config/fish/functions/ that are used
# instead of sourcing `alias` directly for performance reasons.
# use `cas` or source this file directly to generate them and
# remove any dangling ones.

# clear out all generated functions, hopefully skipping
# everything not placed there by this file (including fzf's
# function which is of `find`'s `-type` `l` for link)
rm (find $HOME/.config/fish/functions -type f -not -name 'fish_*')

# brew
# ====

alias -s bi "brew install"
alias -s bin "brew info"
alias -s brm "brew uninstall"
alias -s bs "brew search"
alias -s bup "brew upgrade"

# config
# ======

alias -s ca "vim --cmd 'cd ~/.config/fish' ~/.config/fish/generate-functions.fish"
alias -s cas "source ~/.config/fish/generate-functions.fish"
alias -s caw "vim --cmd 'cd ~/.config/awesome' ~/.config/awesome/rc.lua"
alias -s cf "vim --cmd 'cd ~/.config/fish' ~/.config/fish/config.fish"
alias -s cv "vim --cmd 'cd ~/.config/nvim' ~/.config/nvim/init.lua"

# ding
# ===

function ding --description "Show a notification"
	set last_status $status
	set last_command $_

	if test -n "$argv"
		set title $argv
	else
		set title "ding!"
	end

	if test $last_status = 0
		set sound "glass" # sound of good
		set description "$last_command | $PWD"
	else
		set sound "sosumi" # sound of bad
		set description "($last_status) $last_command | $PWD"
	end

	if test (uname) = 'Darwin'
		/usr/bin/osascript -e "display notification \"$description\" with title \"$title\" sound name \"$sound\""
	end
end
funcsave ding

# fish
# ====

alias -s fns 'functions'

# git
# ===

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
		git commit --no-verify -m "$argv"
	else
		git commit --no-verify
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
		git commit --amend --no-verify -m "$argv"
	else
		git commit --amend --no-verify
	end
end
funcsave gcva

function gcal --wraps "git commit --all -m"
	if test -n "$argv"
		git commit --all -m "$argv"
	else
		git commit --all
	end
end
funcsave gcal

alias -s g "git"
alias -s ga "git add"
alias -s gaa "git add --all"
alias -s gap "git add -p"
alias -s gau "git add -u"
alias -s gb "git branch"
alias -s gcan "git commit --amend --no-edit"
alias -s gck "git checkout"
alias -s gcl "git clone"
alias -s gcvan "git commit --amend --no-verify --no-edit"
alias -s gd "git diff"
alias -s gdc "git diff --cached"
alias -s gf "git fetch"
alias -s gi "git init"
alias -s gl "git log"
alias -s gl1 "git log -n 1"
alias -s glg "git log --color=always --format=oneline --abbrev-commit --decorate -n 10"
alias -s gls "git ls-files"
alias -s gm "git merge"
alias -s gmff "git merge --ff-only"
alias -s gp "git push"
alias -s gpf "git push --force"
alias -s gpl "git pull"
alias -s gpu "git push -u origin master"
alias -s gr "git reset"
alias -s grb "git rebase"
alias -s grba "git rebase --abort"
alias -s grbc "git rebase --continue"
alias -s grbi "git rebase -i"
alias -s grl "git reflog"
alias -s grm "git rm"
alias -s gs "git status"

# npm
# ===

alias -s ndi "npm install -D"
alias -s ngi "npm install -g"
alias -s ngin "npm info -g"
alias -s ngls "npm list -g"
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
alias_if_exists ip ip 'ip --color'
alias_if_exists ls exa 'exa -x --sort type'
alias_if_exists ls1 exa 'exa -1 --sort type'
alias_if_exists lsa exa 'exa -ax --sort type'
alias_if_exists lsa1 exa 'exa -a1 --sort type'
alias_if_exists pacman pacman 'pacman --color=auto'
alias_if_exists ping prettyping

alias -s mkdir 'mkdir -p'
alias -s vim 'nvim'

# misc
# ====

function mkd --description 'Make directory and cd'
	mkdir $argv
	cd $argv[1]
end
funcsave mkd

if test $hostname = 'potet.local'
	function o --description 'Search Obsidian vault' --wraps=v
		v ~/Documents/vet/$argv
	end
	funcsave o
end

alias -s chx 'chmod +x'
alias -s d 'ranger'
alias -s e 'exec'
alias -s ev 'exec nvim'
alias -s f 'ag -g'
alias -s ld 'lazydocker'
alias -s lg 'lazygit'
alias -s nd 'nextd'
alias -s p2 'python2'
alias -s p3 'python3'
alias -s pd 'prevd'
alias -s r 'ag'
alias -s v 'vim'
alias -s vf 'vim (fzf)'

function sudo!!
	eval sudo $history[1]
end
funcsave sudo!!

if test (uname) = "Darwin"
	alias -s flushdns "sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
end
