# Defined in - @ line 1
function bin --wraps='brew info' --description 'alias bin brew info'
    brew info $argv;
end
