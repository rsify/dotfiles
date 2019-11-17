# Defined in - @ line 1
function nglg --wraps='npm list -g' --description 'alias nglg npm list -g'
    npm list -g $argv;
end
