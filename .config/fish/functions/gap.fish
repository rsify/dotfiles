# Defined in - @ line 1
function gap --wraps='git add -p' --description 'alias gap git add -p'
    git add -p $argv;
end
