#!/bin/bash

echo 'tcp|in|d=10050|s=195.242.116.251 # Zabbix proxy' >> /etc/csf/csf.allow
echo '185.204.217.244 #backup6' >> /etc/csf/csf.allow

csf -r 

echo '195.242.116.251' >> /usr/local/directadmin/data/admin/ip_whitelist
echo "ServerActive=195.242.116.251" > /etc/zabbix/zabbix_agentd.d/zabbix_proxy.conf
service zabbix-agent restart
route=`ifconfig venet0:1 | grep inet | cut -d "." -f 13`; ip r a 192.168.0.0/16 via 192.168.68.1 dev venet0 src 192.168.70.$route
rm -f /root/rehd
