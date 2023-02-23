#! /bin/bash

# Prompt for zabbix server
read -p "Enter Zabbix server IP or FQDN: " zabbix_ipfqdn

# Update and install agent
sudo apt update -y
sudo apt install zabbix-agent -y

# Stop service and update config
sudo systemctl stop zabbix-agent.service

sudo sed -i "s/Server=127.0.0.1/Server=$zabbix_ipfqdn/g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/# HostnameItem=system.hostname/HostnameItem=system.hostname/g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/# HostMetadataItem=/HostMetadataItem=system.uname/g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/ServerActive=127.0.0.1/ServerActive=$zabbix_ipfqdn/g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/# StartAgents=3/StartAgents=0/g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/# RefreshActiveChecks=120/RefreshActiveChecks=120/g" /etc/zabbix/zabbix_agentd.conf

# Start agent
sudo systemctl start zabbix-agent.service
