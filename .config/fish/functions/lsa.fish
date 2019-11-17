# Defined in - @ line 1
function lsa --wraps='ls -a' --description 'alias lsa ls -a'
    ls -a $argv;
end
