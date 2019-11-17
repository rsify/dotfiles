# Defined in - @ line 1
function nt --wraps='npm test' --description 'alias nt npm test'
    npm test $argv;
end
