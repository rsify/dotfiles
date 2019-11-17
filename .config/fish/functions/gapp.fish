# Defined in - @ line 1
function gapp --wraps='git apply' --description 'alias gapp git apply'
    git apply $argv;
end
