# Defined in - @ line 1
function gsuba --wraps='git submodule add' --description 'alias gsuba git submodule add'
    git submodule add $argv;
end
