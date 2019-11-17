# Defined in - @ line 1
function gm --wraps='git merge' --description 'alias gm git merge'
    git merge $argv;
end
