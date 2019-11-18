# Defined in - @ line 1
function v --wraps=vim --wraps='env SHELL=/bin/zsh vim' --description 'alias v vim'
    vim  $argv;
end
