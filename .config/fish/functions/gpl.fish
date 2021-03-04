# Defined in - @ line 1
function gpl --wraps='git pull' --description 'alias gpl git pull'
  git pull $argv;
end
