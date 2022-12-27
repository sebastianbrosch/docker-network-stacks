wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-armv7.tar.gz
tar -xvzf node_exporter-1.3.1.linux-armv7.tar.gz
cp node_exporter-1.3.1.linux-armv7/node_exporter /usr/local/bin
chmod +x /usr/local/bin/node_exporter
useradd -m -s /bin/bash node_exporter
mkdir /var/lib/node_exporter
chown -R node_exporter:node_exporter /var/lib/node_exporter
cp node_exporter.service /etc/systemd/system

systemctl daemon-reload
systemctl enable node_exporter.service
systemctl start node_exporter.service

systemctl status node_exporter

rm -r node_exporter-1.3.1.linux-armv7
rm node_exporter-1.3.1.linux-armv7.tar.gz
