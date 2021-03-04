# Defined in /Users/maciek/.config/fish/alias.fish @ line 200
function ding --description 'Show a notification'
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
