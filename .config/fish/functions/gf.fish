# Defined in - @ line 1
function gf --wraps='git fetch' --description 'alias gf git fetch'
    git fetch $argv;
end
