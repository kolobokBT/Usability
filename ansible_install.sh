#!/bin/bash
sudo apt-get update
sudo apt-get install -y python3-pip
sudo apt-get install -y ansible

echo "[all]" > hosts
echo "localhost ansible_connection=local" >> hosts

echo "[servers]" >> hosts
echo "$srvname=$srvip $ansible_user $ssh_path"  >> hosts
echo "$srvname2=$srvip2 $ansible_user $ssh_path" >> hosts
echo "" >> hosts

echo "[defaults]" >> ansible.cfg
echo "host_key_check=false" >> ansible.cfg
echo "inventory=$hosts" >> ansible.cfg
echo "" >> ansible.cfg

ansible -i hosts all -m ping
