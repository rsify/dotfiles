# Defined in - @ line 1
function nrbf --wraps='npm rebuild --force' --description 'alias nrbf npm rebuild --force'
    npm rebuild --force $argv;
end
