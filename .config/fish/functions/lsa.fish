# Defined in - @ line 1
function lsa --wraps='exa -a' --wraps='exa -ax --sort type' --description 'alias lsa exa -ax --sort type'
    exa -ax --sort type $argv;
end
