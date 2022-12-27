# Docker Prometheus Stack

## Grafana
https://hub.docker.com/r/grafana/grafana

## Node Exporter
https://github.com/prometheus/node_exporter/
Install-Script is available in subfolder node-exporter.

## Blackbox Exporter
https://hub.docker.com/r/prom/blackbox-exporter

## SNMP
`sudo apt install snmp`

## PromQL
Speicherplatz (Gesamt):
`node_filesystem_size_bytes{fstype="ext4", job="node-rpi"}`
Speicherplatz (Verfügbar):
`node_filesystem_free_bytes{fstype="ext4", job="node-rpi"}`
Speicherplatz (in Verwendung):
`node_filesystem_size_bytes{fstype="ext4", job="node-rpi"} - node_filesystem_free_bytes{fstype="ext4", job="node-rpi"}`
