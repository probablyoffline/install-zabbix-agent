#! /bin/bash

# Update and install agent
sudo apt update -y
sudo apt install zabbix-agent -y

# Stop service and update config
sudo systemctl stop zabbix-agent.service

sed -i 's/Server=127.0.0.1/Server=system.hostname/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/# HostnameItem=system.hostname/HostnameItem=system.hostname/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/# HostMetadataItem=/HostMetadataItem=system.uname/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1/ServerActive=system.hostname/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/# StartAgents=3/StartAgents=1/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/# RefreshActiveChecks=120/RefreshActiveChecks=120/g' /etc/zabbix/zabbix_agentd.conf

# Remove the script
rm -- "$0"
