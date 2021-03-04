# Defined in - @ line 1
function nin --wraps='npm info' --description 'alias nin npm info'
  npm info $argv;
end
