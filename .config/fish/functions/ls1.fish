# Defined in - @ line 1
function ls1 --wraps='exa -1 --sort type' --description 'alias ls1 exa -1 --sort type'
  exa -1 --sort type $argv;
end
