# create network and stack.
docker network inspect traefik-public >/dev/null 2>&1 || docker network create --driver=overlay traefik-public
docker stack deploy -c $(dirname $(realpath "$BASH_SOURCE"))/docker-compose.yml prometheus
