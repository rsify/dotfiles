# Defined in - @ line 1
function grm --wraps='git rm' --description 'alias grm git rm'
  git rm $argv;
end
