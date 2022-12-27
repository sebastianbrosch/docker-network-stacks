#!/bin/bash
source functions.sh

function get_swarm_state {
  docker info --format "{{.Swarm.LocalNodeState}}"
}

if [[ $(get_swarm_state) = 'inactive' ]]; then
  printf '%b[\u274c] %s%b\n' $RED 'Docker Swarm is inactive.' $ENDCOLOR
  printf '    Initialize Docker Swarm? [Y/\e[4mN\e[0m]: '
  read -p "" swarm_enable
  swarm_enable=${swarm_enable:-N}
  
  if [[ ! $swarm_enable =~ [YyJj] ]]; then
    printf '    %b%s%b\n' $YELLOW 'Docker Swarm is not getting initialized.' $ENDCOLOR
    printf '    %b%s%b\n\n' $RED 'Abort' $ENDCOLOR
    exit 1
  else
    printf '    %b%s%b%b' $YELLOW 'Docker Swarm is getting initialized...' $ENDCOLOR $RESET
    docker swarm init > /dev/null
    printf '    %b%s%b%b\n\n' $GREEN 'Docker Swarm is initialized.' $ENDCOLOR $RESET

    if [[ $(get_swarm_state) = 'inactive' ]]; then
      printf '    %b%s%b\n' $YELLOW 'Docker Swarm is not getting initialized.' $ENDCOLOR
      printf '    %b%s%b\n\n' $RED 'Abort' $ENDCOLOR
    else
      printf '%b[\u2714] %s%b\n\n' $GREEN 'Docker Swarm is active.' $ENDCOLOR
    fi
  fi
else
  printf '%b[\u2714] %s%b\n\n' $GREEN 'Docker Swarm is active.' $ENDCOLOR
fi