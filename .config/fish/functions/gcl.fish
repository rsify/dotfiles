# Defined in - @ line 1
function gcl --wraps='git clone' --description 'alias gcl git clone'
  git clone $argv;
end
