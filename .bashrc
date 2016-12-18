#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
export PS1="\[\e[1m\]\[\e[38;5;161m\]\u@\H \[\e[0m\]\[\e[38;5;154m\]\w \[\e[1m\]\[\e[38;5;161m\]\$\[\e[0m\] "


# uncomment to force steam to use new libs (whatever that means lol)
# export LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so'

# if hash fish 2>/dev/null; then
# 	fish && exit
# else
# 	echo "fish not installed, do it now"
# fi
