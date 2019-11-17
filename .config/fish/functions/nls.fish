# Defined in - @ line 1
function nls --wraps='npm list' --description 'alias nls npm list'
    npm list $argv;
end
