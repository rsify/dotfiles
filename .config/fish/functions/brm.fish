# Defined via `source`
function brm --wraps='brew uninstall' --description 'alias brm brew uninstall'
  brew uninstall $argv; 
end
