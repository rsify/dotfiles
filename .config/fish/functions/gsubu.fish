# Defined in - @ line 1
function gsubu --wraps='git submodule update' --description 'alias gsubu git submodule update'
  git submodule update $argv;
end
