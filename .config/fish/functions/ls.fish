# Defined in - @ line 1
function ls --wraps='exa -x --sort type' --description 'alias ls exa -x --sort type'
    exa -x --sort type $argv;
end
