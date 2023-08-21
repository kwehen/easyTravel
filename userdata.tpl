#!/bin/bash
wget --header 'Authorization: token INSERT_TOKEN_HERE' https://raw.githubusercontent.com/USER/REPO/main/easytravel-install.sh
chmod +x easytravel-install.sh
sudo bash easytravel-install.sh -i
