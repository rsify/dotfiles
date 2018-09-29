#!/bin/bash
file="$HOME/Notes/inbox/$(~/.config/bin/iso-date.sh)"
touch "$file"
echo -n "$file"
