#!/bin/bash

echo ===========================================
echo 01/16/2020 INIT SCRIPT FOR UBUNTU 18.04 LTS
echo ===========================================
echo

# sudo permission
apt-get install -y sudo

# archive server to kakao
echo archive server to korea kakao? y/n
read a
if [[ $a == y ]]; then
    sudo sed -i 's/kr.archive.ubuntu.com/ftp.daumkakao.com/' /etc/apt/sources.list
fi

# update
sudo apt-get update -y


# build essentials
sudo apt-get install -y \
    build-essential \
    gcc g++ gdb \
    vim \
    openjdk-8-jre \
    python3 python3-pip \
    curl net-tools \
    htop \
    software-properties-common

# git
sudo apt-get install git
git config --global core.editor "vim"
git_path=~/.gitconfig
sudo cat >> ${git_path} << EOF
[alias]
lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
lg = !"git lg1"
EOF

# node
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs npm
sudo npm i -g pm2 gtop yarn

# vimrc setting
git clone --depth=1 https://github.com/ckcks12/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cp ~/.vimrc ~/.ideavimrc

# zsh
sudo apt-get install -y zsh powerline fonts-powerline
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
sed -i 's/robbyrussell/agnoster/' ~/.zshrc
chsh -s /bin/zsh
rc=~/.zshrc
sudo echo alias l=\"ls -alFh\" >> ${rc}
source ${rc}

# DOCKER
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io

# golang
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt-get update -y
sudo apt-get install golang-go
sudo echo export GOPATH=~/.go > ~/.zsh
source $HOME/.zshrc

# server setting
sudo sysctl fs.inotify.max_user_watches=524288

echo DONE
