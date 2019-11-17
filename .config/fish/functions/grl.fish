# Defined in - @ line 1
function grl --wraps='git reflog' --description 'alias grl git reflog'
    git reflog $argv;
end
