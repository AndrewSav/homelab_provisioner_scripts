#!/bin/bash

set -e
USR=$1
NAME=$2
KEY=$3
PASS=$4

sudo useradd -m -c "$NAME" -s /bin/bash "$USR"
HOM=$(eval echo "~$USR")
sudo mkdir -p "$HOM/.ssh"
sudo chmod 700 "$HOM/.ssh"

sudo tee "$HOM/.ssh/authorized_keys" >/dev/null <<.
$KEY
.

sudo chmod 600 "$HOM/.ssh/authorized_keys"
sudo chown -R "$USR:$USR" "$HOM"

if [[ $PASS ]]; then
sudo tee "/etc/sudoers.d/$USR" >/dev/null <<.
$USR ALL=(ALL) ALL
.

echo -e "$PASS\n$PASS" | sudo passwd "$USR"
else
sudo tee "/etc/sudoers.d/$USR" >/dev/null <<.
$USR ALL=NOPASSWD: ALL
.

fi

echo "Created user $NAME"
