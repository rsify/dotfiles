# Defined in - @ line 1
function gau --wraps='git add -u' --description 'alias gau git add -u'
  git add -u $argv;
end
