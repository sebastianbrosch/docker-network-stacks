sed -i "s/((IPV4))/$SERVER_IPV4/g" $(dirname $(realpath "$BASH_SOURCE"))/prometheus.yml
sed -i "s/((IPV4))/$SERVER_IPV4/g" $(dirname $(realpath "$BASH_SOURCE"))/grafana.ini
docker network inspect traefik-public >/dev/null 2>&1 || docker network create --driver=overlay traefik-public
docker stack deploy -c $(dirname $(realpath "$BASH_SOURCE"))/docker-compose.yml prometheus