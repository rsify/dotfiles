# Defined in - @ line 1
function brm --wraps='brew uninstall' --description 'alias brm brew uninstall'
    brew uninstall $argv;
end
