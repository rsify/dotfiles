# Defined in - @ line 1
function gpf --wraps='git push --force' --description 'alias gpf git push --force'
  git push --force $argv;
end
