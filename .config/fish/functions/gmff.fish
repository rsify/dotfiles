# Defined in - @ line 1
function gmff --wraps='git merge --ff-only' --description 'alias gmff git merge --ff-only'
    git merge --ff-only $argv;
end
