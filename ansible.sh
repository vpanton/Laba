#!/bin/bash
mkdir -p ~/ansible/venv && cd ~/ansible/venv
virtualenv --no-site-packages ansible
source ansible/bin/activate
pip install ansible boto
ansible-galaxy install wunzeco.telegraf
wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py -O ~/ansible/ec2.py
