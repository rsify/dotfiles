# Defined in - @ line 1
function nrm --wraps='npm uninstall' --description 'alias nrm npm uninstall'
  npm uninstall $argv;
end
