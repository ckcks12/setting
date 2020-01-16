#!/bin/bash

sudo add-apt-repository ppa:numix/ppa
sudo apt update
sudo apt install numix-icon-theme-circle

gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close
sudo ./Qogir-theme/install.sh
