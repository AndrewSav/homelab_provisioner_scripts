#!/bin/bash

set -e

sudo /bin/rm /etc/ssh/ssh_host_*
sudo systemctl restart sshd
