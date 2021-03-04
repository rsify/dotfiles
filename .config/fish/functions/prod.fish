# Defined in /Users/maciek/.config/fish/alias.fish @ line 335
function prod --description 'productivotivoti mode' --argument mode
	set apps Mail Discord Caprine Skype Telegram Messages

	for app in $apps
		if test "$mode" = "on"
			osascript -e "quit app \"$app\"" &
		else if test "$mode" = "off"
			open -gja "$app" &
		end
	end
end
