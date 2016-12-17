function fish_title
	string replace -r "^$HOME" "~" (pwd)
	echo " | "
	hostname
end
