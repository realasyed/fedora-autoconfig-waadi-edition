#!/bin/bash

#Fedora Autoconfig: Waadi Edition by Armaan Syed.
#Created on July 15th, 2022

#Introduction
echo "Welcome to Fedora Autoconfig: Waadi Edition! This script's primary goal is to optimize Fedora
Linux laptops for school and office environments on low end machines. If you fit this criterion and
are not Waadi, feel free to use this script anyways."
echo "IMPORTANT: The user insterface or 'Desktop Environment' that Fedora Linux uses by default is called 'GNOME'
(pronounced GUH-NOME). This DE is very simple and designed to stay out of your way. As a result, GNOME is perfect for
office workers, coders, and students. However, although it still gives you significantly more customization options than Windows, it gives you less control than other Desktop Environments like KDE and XFCE. Also, Linux is a 'live kernel'
which means that you don't have to reboot for 99% of updates. Just keep that in mind so you don't waste your time. Also,
when in doubt, resort to people you know, Reddit, YouTube, the 'man' command, and the Arch Wiki; these are THE resources
for Linux."

sleep 1

#introduction
echo "Before we begin, I need to know what you plan on doing with your machine:"

echo "Do you plan on doing some gaming on this machine? (y/n)"
read GAMING

echo "Do you plan on using any Logitech devices with this machine? (y/n)"
read LOGITECH

echo "Do you need an offline office suite? (Think Microsoft 365) (y/n)"
read OFFICE

echo "Do you want to install Google Chrome? WARNING: Google Chrome EATS memory. I reccomend using Chromium or Firefox as alternatives. (y/n)"
read CRINGE

echo "Thank you for using Fedora Autoconfig: Waadi Edition! Configuration will begin now..."

#initial upgrades
echo "Updating system..."
yes | sudo dnf --refresh upgrade

#extra repos
echo "Adding extra repos..."
#rpm fusion
yes | sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
yes | sudo dnf groupupdate core
yes | sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
yes | sudo dnf groupupdate sound-and-video
#flatpak
yes | flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#google chrome
sudo dnf config-manager --set-enabled google-chrome

#refresh
echo "Refreshing system..."
yes | sudo dnf --refresh upgrade
yes | sudo flatpak update

#downloads
echo "Downloading essential software and fonts..."
yes | sudo dnf install gnome-tweaks
yes | sudo dnf install gnome-extensions-app 
yes | sudo dnf install curl cabextract xorg-x11-font-utils fontconfig
yes | sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
yes | sudo dnf install wine
yes | sudo dnf install bottles

#optional downloads
#gaming
if [[ $GAMING == "y" || $GAMING == "Y" ]]; then
	echo "Installing gaming related software..."
	yes | sudo dnf install steam
	yes | sudo dnf install lutris
else
	echo "No gaming related software was downloaded."
fi

#logitech
if [[ $LOGITECH == "y" || $LOGITECH == "Y" ]]; then
	echo "Installing Solaar..."
	yes | sudo dnf install solaar
else
	echo "No Logitech related software was downloaded."
fi

#office
if [[ $OFFICE == "y" || $OFFICE == "Y" ]]; then
	echo "Installing Libre Office..."
	yes | sudo dnf install libreoffice
else
	echo "No office software was downloaded."
fi

#cringe
if [[ $CRINGE == "y" || $CRINGE == "Y" ]]; then
	echo "Installng Google Cringe..."
	yes | sudo dnf install google-chrome-stable
else 
	echo "No cringe was installed. Nice."
fi

echo "Thank you for using Fedora Autoconfig: Waadi Edition! Your system may need to reboot now."
echo "Reboot? (y/n)"
read REBOOTN
if [[ $REBOOTN == "y" || $REBOOTN == "Y" ]]; then
	sudo reboot now
else
	echo "Your system will not reboot. Thank you for using my config!"
fi
