#!/bin/bash

set -e
USR=$1
sudo sed -E -i 's|^#?(PasswordAuthentication)\s.*|\1 no|' /etc/ssh/sshd_config
if [[ ! $(sudo grep '^PasswordAuthentication\s' /etc/ssh/sshd_config) ]]; then echo 'PasswordAuthentication no' |sudo tee -a /etc/ssh/sshd_config; fi
sudo passwd "$USR" -l
