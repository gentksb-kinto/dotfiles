#!/usr/bin/env bash
set -ue

# ssm-sessionの前提をインストール
sudo apt -y update
sudo apt -y install jq
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
echo "jq and fzf installed!"

# aws cli2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# ssm-sessionをインストール
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
cp ./module/ssm-session /usr/bin/
echo "ssm-session tool installed!"

# node & awsp
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install n -g
sudo n lts
sudo apt purge -y nodejs
exec $SHELL -l
sudo npm install awsp -g

# tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
