#!/bin/bash
sudo apt-get update

sudo apt install -y vim tmux tree git ca-certificates curl jq unzip zsh 
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-compose


git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.8.14
pyenv global 3.8.14