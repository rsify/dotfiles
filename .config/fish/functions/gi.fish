# Defined in - @ line 1
function gi --wraps='git init' --description 'alias gi git init'
    git init $argv;
end
