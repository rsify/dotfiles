# Defined in - @ line 1
function bup --wraps='brew upgrade' --description 'alias bup brew upgrade'
    brew upgrade $argv;
end
