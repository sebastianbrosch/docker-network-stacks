# Docker Network Stacks
Docker Stacks to provide services on the network.

## Overview

This repository contains several Docker Stacks which are dependent on each other. The Traefik stack is the central stack. The reverse proxy allows easy access to the different services.

## Traefik

The reverse proxy Traefik is the central stack which provides easy access to the other services. All stacks are organizes in a network called `traefik-public`. This network is created by this command:

```
docker network inspect traefik-public >/dev/null 2>&1 || docker network create --driver=overlay traefik-public
```

Traefik and the needed network can be installed by using the shell script `install.sh`. The shell script sets the variables used in the `docker-compose.yml` file. Please change the values for your needs.

## Prometheus

This stack enables the monitoring of network devices. This stack also includes a speed test which performs a speed test at regular intervals. With Grafana the results of the measurements can be displayed.

## Pi-hole

Pi-hole is an adblocker and DNS server. It can be used to block advertisements, telemetry and malicious websites throughout the network.

Pi-hole is using the port 53 (UDP and TCP) of the host system.