# Defined in /Users/nikersify/.config/fish/alias.fish @ line 296
function mkd --description 'Make directory and cd'
    mkdir $argv
	cd $argv[1]
end
