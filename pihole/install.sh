printf '\n    [Pi Hole]'
printf '\n        Web-Password: \033[s'
read webpassword
webpassword=${webpassword:-"pihole"}
printf '\033[u%s\n' $webpassword

export WEBPASSWORD=$webpassword

docker stack deploy -c $(dirname $(realpath "$BASH_SOURCE"))/docker-compose.yml pihole > /dev/null