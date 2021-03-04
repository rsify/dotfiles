# Defined in - @ line 1
function gck --wraps='git checkout' --description 'alias gck git checkout'
  git checkout $argv;
end
