#!/bin/bash

# adapted from https://gist.github.com/megalithic/cd957de7c6905e8bb2c3

NOW_PLAYING=$(osascript <<EOF
	if app_is_running("Radiant Player") then
		tell application "Radiant Player"
			set artist to current song artist
			set track to current song name
			set state to player state
			if state is 1 then
				-- paused
				return ""
			else if state is 2 then
				-- playing
				return "♫ " & artist & " - " & track
			else if state is 0 then
				if artist is missing value then
					-- stopped
					return ""
				else
					-- status isn\'t coming across correctly
					return "♫ " & artist & " - " & track
				end
			end if
		end tell
	end if
	on app_is_running(app_name)
		tell app "System Events" to (name of processes) contains app_name
	end app_is_running
EOF)

if [[ $NOW_PLAYING ]]; then
	echo " "$NOW_PLAYING" "
fi
