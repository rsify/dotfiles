function proxy --description 'Toggle system proxy'
	networksetup -setwebproxystate Wi-Fi $argv
	networksetup -setsecurewebproxystate Wi-Fi $argv
end
