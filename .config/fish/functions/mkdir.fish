# Defined in - @ line 1
function mkdir --wraps='mkdir -p' --description 'alias mkdir mkdir -p'
 command mkdir -p $argv;
end
