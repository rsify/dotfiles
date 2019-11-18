# Defined in - @ line 1
function vim --wraps=nvim --wraps='env SHELL=/bin/zsh nvim' --description 'alias vim env SHELL=/bin/zsh nvim'
    env SHELL=/bin/zsh nvim $argv;
end
