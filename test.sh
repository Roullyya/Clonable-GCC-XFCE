#!/bin/bash

#if [ "$EUID" -ne 0 ]; then
#  echo "Ce script doit être exécuté en tant que superutilisateur (root)." >&2
#  exit 1
#fi
#apt update
#apt upgrade -y
#curl -L -o chrome-remote-desktop_current_amd64.deb \
#    https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
#DEBIAN_FRONTEND=noninteractive \
#apt-get install --assume-yes ./chrome-remote-desktop_current_amd64.deb
#apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver
#bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
#systemctl disable lightdm.service
#Installer la suite complète xfce
#apt install --assume-yes task-xfce-desktop
#apt install --assume-yes firefox-esr

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Ce script doit être exécuté en tant que superutilisateur (root)." >&2
  exit 1
fi

# decompression de preferrence mozilla
cat backup.tar.gz-000* > moz.tar.gz
tar -xf moz.tar.gz
cd /home/remi_duclos_98/Clonable-GCC-XFCE/home/remi_duclos_98/Desktop
mv mozilla/ /home/remi_duclos_98/.mozilla
cd /home/remi_duclos_98/Clonable-GCC-XFCE/

#installation de expect
apt install expect -y

#création de l'utilisateur ahab avec le mdp Ahab1
expect ./ahab.exp
cp ./XFCE.exp /home/ahab
cp ./chrome.exp /home/ahab
rm ./XFCE.exp
cd /home/ahab
adduser ahab sudo

# Téléchargement du paquet
curl -L -o chrome-remote-desktop_current_amd64.deb \
    https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

# Installation du paquet
expect chrome.exp
# Update the package lists
apt update

# Install the Chrome Remote Desktop package
#apt install --assume-yes chrome-remote-desktop

# Install the Xfce desktop environment par expect
expect ./XFCE.exp

# Set the default session to Xfce
bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

# Disable the LightDM display manager
systemctl disable lightdm.service

# Install Firefox ESR
apt install --assume-yes firefox-esr neofetch htop 

#copie des preferences firefox
rm -r /home/ahab/.mozilla
mv /home/remi_duclos_98/.mozilla /home/ahab/.mozilla

#nettoyage
rm -r /home/remi_duclos_98
rm ./chrome.exp
rm ./chrome-remote-desktop_current_amd64.deb
rm ./README-cloudshell.txt
rm ./XFCE.exp
apt purge -y
apt autoremove expect -y
su ahab


