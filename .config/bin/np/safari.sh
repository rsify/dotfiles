#!/bin/bash

NOW_PLAYING=$(osascript <<EOF
	tell application "Safari"
		repeat with t in tabs of windows
			tell t
				return name
				-- TODO: return youtube tab title if is playing
				-- https://gist.github.com/fent/7763775
			end tell
		end repeat
	end tell
EOF)

if [[ $NOW_PLAYING ]]; then
	echo " "$NOW_PLAYING" "
fi
