#!/bin/bash
ipv4=$(ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1 | head -1)
ipv6=$(ip -o -6 addr list eth0 | awk '{print $4}' | cut -d/ -f1 | head -1)

function get_traefik_cnt {
  docker service ls --format {{.Name}} | awk '/^traefik_/ {count++} END {print count}'
}
function get_prometheus_cnt {
  docker service ls --format {{.Name}} | awk '/^prometheus_/ {count++} END {print count}'
}
function get_pihole_cnt {
  docker service ls --format {{.Name}} | awk '/^pihole_/ {count++} END {print count}'
}

source functions.sh

clear
hline "="
printf '%b%s%b\n' $GREEN "$(ctext 'Docker Network Stacks')" $ENDCOLOR
hline "="
echo

bash docker.sh

if [[ $? > 0 ]]; then
  exit 1
fi

printf '%bRaspberry Pi%b\n' $BLUE $ENDCOLOR
printf '    IP-Adresse (IPv4) [%s]: \033[s' $ipv4
read ip4
ip4=${ip4:-${ipv4}}
printf '\033[u%s\n' $ip4

printf '    IP-Adresse (IPv6) [%s]: \033[s' $ipv6
read ip6
ip6=${ip6:-${ipv6}}
printf '\033[u%s\n' $ip6

export SERVER_IPV4=$ip4
export SERVER_IPV6=$ip6

printf '\n%bDocker Stacks%b\n' $BLUE $ENDCOLOR

printf '    Traefik [Y/%bN%b]: \033[s' $UNDERLINE $ENDCOLOR
read traefik
traefik=${traefik:-N}

if [[ $traefik =~ [YyJj] ]]; then
  traefik=Y
else
  traefik=N
fi
printf '\033[u%s\n' $traefik

printf '    Prometheus (incl. Grafana) [Y/%bN%b]: \033[s' $UNDERLINE $ENDCOLOR
read prometheus
prometheus=${prometheus:-N}

if [[ $prometheus =~ [YyJj] ]]; then
  prometheus=Y
else
  prometheus=N
fi
printf '\033[u%s\n' $prometheus

printf '    Pi Hole [Y/%bN%b]: \033[s' $UNDERLINE $ENDCOLOR
read pihole
pihole=${pihole:-N}

if [[ $pihole =~ [YyJj] ]]; then
  pihole=Y
else
  pihole=N
fi
printf '\033[u%s\n' $pihole

printf '\n%bInstall Docker Stacks%b\n' $BLUE $ENDCOLOR

if [[ ! $traefik =~ [YyJj] && ! $prometheus =~ [YyJj] && ! $pihole =~ [YyJj] ]]; then
  printf '    %bNo Docker Stack selected to install.%b\n' $YELLOW $ENDCOLOR
  printf '    %bFinished.%b' $GREEN $ENDCOLOR
fi

if [[ $traefik =~ [YyJj] ]]; then
  printf '    Traefik is being installed...%b' $RESET
  bash traefik/install.sh > /dev/null 2>&1
  if [[ $(get_traefik_cnt) == 2 ]]; then
    printf '    %b[\u2714] Traefik wurde installiert.%b%b\n' $GREEN $ENDCOLOR $RESET
  else
    printf '    %b[\u274c] Traefik wurde nicht installiert.%b%b\n' $RED $ENDCOLOR $RESET
  fi
fi

if [[ $prometheus =~ [YyJj] ]]; then
  printf '    Prometheus (incl. Grafana) is being installed...%b' $RESET
  bash prometheus/install.sh > /dev/null 2>&1
  if [[ $(get_prometheus_cnt) == 3 ]]; then
    printf '    %b[\u2714] Prometheus (incl. Grafana) wurde installiert.%b%b\n' $GREEN $ENDCOLOR $RESET
  else
    printf '    %b[\u274c] Prometheus (incl. Grafana) wurde nicht installiert.%b%b\n' $RED $ENDCOLOR $RESET
  fi
fi

if [[ $pihole =~ [YyJj] ]]; then
  printf '    Pi Hole is being installed...%b' $RESET
  bash pihole/install.sh > /dev/null 2>&1
  if [[ $(get_pihole_cnt) == 1 ]]; then
    printf '    %b[\u2714] Pi Hole wurde installiert.%b%b\n' $GREEN $ENDCOLOR $RESET
  else
    printf '    %b[\u274c] Pi Hole wurde nicht installiert.%b%b\n' $RED $ENDCOLOR $RESET
  fi
fi

printf '\nPress [Enter] key to exit the setup...'
read -p ""
clear