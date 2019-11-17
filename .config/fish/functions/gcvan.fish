# Defined in - @ line 1
function gcvan --wraps='git commit --amend -n --no-edit' --description 'alias gcvan git commit --amend -n --no-edit'
    git commit --amend -n --no-edit $argv;
end
