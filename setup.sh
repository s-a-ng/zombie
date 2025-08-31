#!/bin/bash
set -e

sudo ufw disable

#sudo apt update && sudo apt upgrade -y

#sudo apt install -y wget curl gdebi-core desktop-base xscreensaver
#sudo apt install -y xfce4 xfce4-goodies

sudo apt-get update -y
sudo apt-get install -y wget curl gdebi-core desktop-base xscreensaver xfce4 xfce4-goodies

echo "exec /usr/bin/xfce4-session" > ~/.chrome-remote-desktop-session

wget -O /tmp/chrome-remote-desktop.deb https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo gdebi -n /tmp/chrome-remote-desktop.deb
rm /tmp/chrome-remote-desktop.deb

wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n /tmp/google-chrome.deb
rm /tmp/google-chrome.deb
