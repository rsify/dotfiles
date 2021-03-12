# Defined via `source`
function dc --wraps=docker-compose --description 'alias dc docker-compose'
  docker-compose $argv; 
end
