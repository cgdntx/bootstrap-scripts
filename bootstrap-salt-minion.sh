#!/bin/bash

ssh-keygen -f ~/.ssh/id_rsa -N ""

apt-get install -y gnupg2

wget -O - https://repo.saltstack.com/py3/ubuntu/20.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo 'deb http://repo.saltstack.com/py3/ubuntu/20.04/amd64/latest focal main' >> /etc/apt/sources.list.d/saltstack.list

apt-get update

apt-get install -y salt-minion

systemctl enable salt-minion
systemctl stop salt-minion

echo 'startup_states: highstate' >> /etc/salt/minion.d/bootstrap.conf
echo 'minion_id_caching: False' >> /etc/salt/minion.d/bootstrap.conf
echo 'minion_id_lowercase: True' >> /etc/salt/minion.d/bootstrap.conf

rm -F /etc/salt/minion_id

systemctl start salt-minion
