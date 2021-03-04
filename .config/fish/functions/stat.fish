# Defined in - @ line 1
function stat --wraps=gstat --description 'alias stat gstat'
  gstat  $argv;
end
