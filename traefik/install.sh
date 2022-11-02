# set variables as needed.
export SERVER_IP=192.168.0.9

# create network and stack.
docker network inspect traefik-public >/dev/null 2>&1 || docker network create --driver=overlay traefik-public
docker stack deploy -c docker-compose.yml traefik