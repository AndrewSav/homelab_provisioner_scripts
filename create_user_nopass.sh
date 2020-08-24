#!/bin/bash

set -e
USR=$1
NAME=$2
GITHUB_USERNAME=$3

KEYS=$(get_keys $GITHUB_USERNAME)
KEYS=$(echo "$KEYS" | sed '/^ssh-rsa/!d')

if [[ $KEYS != ssh-rsa* ]]; then
  echo "Keys for github user $GITHUB_USERNAME are not found"
  exit 1
fi

sudo useradd -m -c "$NAME" -s /bin/bash "$USR"
HOM=$(eval echo "~$USR")
sudo mkdir -p "$HOM/.ssh"
sudo chmod 700 "$HOM/.ssh"

sudo tee "$HOM/.ssh/authorized_keys" >/dev/null <<.
$KEYS
.

sudo chmod 600 "$HOM/.ssh/authorized_keys"
sudo chown -R "$USR:$USR" "$HOM"
sudo tee "/etc/sudoers.d/$USR" >/dev/null <<.
$USR ALL=NOPASSWD: ALL
.

echo "Created user $NAME"
