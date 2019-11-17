# Defined in /Users/nikersify/.config/fish/alias.fish @ line 252
function proxy --description 'Toggle system proxy'
    networksetup -setwebproxystate Wi-Fi $argv
	networksetup -setsecurewebproxystate Wi-Fi $argv
end
