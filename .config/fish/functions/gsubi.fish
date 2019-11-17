# Defined in - @ line 1
function gsubi --wraps='git submodule init' --description 'alias gsubi git submodule init'
    git submodule init $argv;
end
