#!/usr/bin/env bash
set -ue

# ssm-sessionの前提をインストール
sudo apt -y update
sudo apt -y install jq
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# aws cli2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# ssm-sessionをインストール
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
cp ./module/ssm-session /usr/bin/

# node & awsp
sudo apt install -y nodejs npm
sudo npm install n -g
sudo n lts
sudo apt purge -y nodejs npm
exec $SHELL -l
sudo npm install awsp -g