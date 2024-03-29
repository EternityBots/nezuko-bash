#!/bin/bash
# Base made through ChatGPT
# Set an environment variable based on the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Check for specific Linux distributions
    if [[ -f /etc/arch-release ]]; then
        # Install packages on Arch Linux
        echo "Detect OS :- Arch Linux" 
        sleep 3       
        sudo pacman -Syu --noconfirm ffmpeg nodejs-lts-hydrogen git imagemagick npm
        sudo npm install --global yarn
        clear
    elif [[ -f /etc/fedora-release ]]; then
        # Install packages on Fedora
        echo "Detect OS :- Fedora Linux" 
        sleep 3 
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf install -y ffmpeg nodejs git ImageMagick yarnpkg
        clear
    elif [[ -f /etc/lsb-release && "$(cat /etc/lsb-release | grep DISTRIB_ID)" == *"Ubuntu"* ]]; then
        # Install packages on Ubuntu
        echo "Detect OS :- Ubuntu Linux"
        sleep 3 
        sudo apt-get update
        sudo apt-get install -y ffmpeg git curl imagemagick
        curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
        sudo npm install --global yarn
        npm install --global yarn
        clear
    elif [[ -f /etc/debian_version ]]; then
        # Install packages on Debian
        echo "Detect OS :- Debian Linux"
        sleep 3 
        sudo apt-get update
        sudo apt-get install -y ffmpeg git curl imagemagick
        curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
        sudo npm install --global yarn
        npm install --global yarn
        clear
    elif [[ -f /etc/redhat-release ]]; then
        # Install packages on Red Hat
        echo "Detect OS :- RedHat Linux"
        sleep 3 
        sudo yum install -y ffmpeg nodejs git ImageMagick yarnpkg
        clear
    else
        echo "Unknown Linux distribution"
        exit 1
    fi
elif [[ "$OSTYPE" == "linux-android"* ]]; then
    # Install packages on Termux
    pkg install -y ffmpeg nodejs git imagemagick libwebp yarn
    clear
elif [[ "$OSTYPE" == "linux"* ]]; then
    if [[ -f /etc/os-release && "$(cat /etc/os-release | grep ID_LIKE)" == *"suse"* ]]; then
        # Install packages on openSUSE
        echo "Detect OS :- openSUSE Linux" 
        sleep 3
        sudo zypper install -y ffmpeg-5 nodejs18 git ImageMagick 
        sudo zypper install -y nodejs18 git ImageMagick ffmpeg-4
        sudo npm install --global yarn
        clear
    fi  
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Install packages on macOS
    brew install ffmpeg nodejs git imagemagick yarn
    clear
else
    echo "Unsupported operating system"
    exit 1
fi

# Clone the Nezuko repository
echo "Copying Nezuko Script 🌐"

git clone https://github.com/EternityBots/Nezuko.git

# Change into the Nezuko directory
cd Nezuko

# Install dependencies using yarn
yarn install
clear

# Prompt the user to set environment variables
read -p "Enter MongoDB URI: " MONGODB_URI
read -p "Enter your mobile number: " NUM
read -p "Enter bot prefix: " BOT_PREFIX
read -p "Enter session ID: " SESSION_ID
read -p "Enter Google API key: " GOOGLE_API_KEY
read -p "Enter weatherapi.com API key: " WEATHER_API_KEY
read -p "Enter MyAnimeList username: " MAL_USERNAME
read -p "Enter MyAnimeList password: " MAL_PASSWORD

# Set environment variables
echo "MONGODB=$MONGODB_URI" > .env
echo "MODS=$NUM" >> .env
echo "PREFIX=$BOT_PREFIX" >> .env
echo "SESSION_ID=$SESSION_ID" >> .env
echo "GOOGLE_API=$GOOGLE_API_KEY" >> .env
echo "WEATHER_API=$WEATHER_API_KEY" >> .env
echo "MAL_USERNAME=$MAL_USERNAME" >> .env
echo "MAL_PASSWORD=$MAL_PASSWORD" >> .env

echo "✅ Environment variables set successfully"
clear 
# Start the Nezuko bot
echo "Starting Nezuko Bot 💕💕💕💕💕💕💕💕💕"

sudo bash loop.sh