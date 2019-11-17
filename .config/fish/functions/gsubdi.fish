# Defined in - @ line 1
function gsubdi --wraps='git submodule deinit' --description 'alias gsubdi git submodule deinit'
    git submodule deinit $argv;
end
