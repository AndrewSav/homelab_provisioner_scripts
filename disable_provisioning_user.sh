#!/bin/bash

set -e
USR=$1
sudo passwd "$USR" -l
