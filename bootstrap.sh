#!/bin/sh

{
	sleep 2m
	exit 1
} & # timing out after 2 minutes

cd ~

if ! hash fish 2>/dev/null; then
	echo "fish shell not installed, aborting."
	exit 2
elif ! hash curl 2>/dev/null; then
	echo "curl not installed, aborting."
	exit 3
else
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
	fish -c "fisher"
	cp --remove-destination -v ~/.config/fish/custom/* ~/.config/fish/functions/	
	source ~/.config/fish/functions/*
fi

echo "done."
exit 0
