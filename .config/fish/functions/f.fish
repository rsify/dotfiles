# Defined in - @ line 1
function f --wraps='ag -g' --description 'alias f ag -g'
  ag -g $argv;
end
