# Defined in - @ line 1
function bt --wraps='brew tap' --description 'alias bt brew tap'
  brew tap $argv;
end
