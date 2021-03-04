# Defined in /Users/maciek/.config/fish/alias.fish @ line 306
function mkd --description 'Make directory and cd'
	mkdir $argv
	cd $argv[1]
end
