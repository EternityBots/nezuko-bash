#!/bin/bash

# Set an environment variable based on the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Check for specific Linux distributions
    if [[ -f /etc/arch-release ]]; then
        # Install packages on Arch Linux
        sudo pacman -Syu --noconfirm ffmpeg nodejs git ImageMagick yarn
    elif [[ -f /etc/fedora-release ]]; then
        # Install packages on Fedora
        sudo dnf install -y ffmpeg nodejs git Imagemagick yarnpkg
    elif [[ -d $HOME/.termux ]]; then
        # Install packages on Termux
        pkg install -y ffmpeg nodejs git imagemagick yarn
    elif [[ -f /etc/lsb-release && "$(cat /etc/lsb-release | grep DISTRIB_ID)" == *"Ubuntu"* ]]; then
        # Install packages on Ubuntu
        sudo apt-get update
        sudo apt-get install -y ffmpeg nodejs git imagemagick yarn
    elif [[ -f /etc/debian_version ]]; then
        # Install packages on Debian
        sudo apt-get update
        sudo apt-get install -y ffmpeg nodejs git imagemagick yarn
    elif [[ -f /etc/redhat-release ]]; then
        # Install packages on Red Hat
        sudo yum install -y ffmpeg nodejs git imagemagick yarn
    elif [[ -f /etc/os-release && "$(cat /etc/os-release | grep ID)" == *"opensuse"* ]]; then
        # Install packages on openSUSE
        sudo zypper install -y ffmpeg nodejs git imagemagick yarn
    else
        echo "Unknown Linux distribution"
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Install packages on macOS
    brew install ffmpeg nodejs git imagemagick yarn
else
    echo "Unsupported operating system"
    exit 1
fi

# Clone the Nezuko repository
git clone https://github.com/EternityBots/Nezuko.git

# Change into the Nezuko directory
cd Nezuko

# Install dependencies using yarn
yarn install

# Prompt the user to set environment variables
read -p "Enter MongoDB URI: " MONGODB_URI
read -p "Enter bot prefix: " BOT_PREFIX
read -p "Enter session ID: " SESSION_ID
read -p "Enter Google API key: " GOOGLE_API_KEY
read -p "Enter OpenWeatherMap API key: " WEATHER_API_KEY
read -p "Enter MyAnimeList username: " MAL_USERNAME
read -p "Enter MyAnimeList password: " MAL_PASSWORD

# Set environment variables
export MONGODB_URI=$MONGODB_URI
export BOT_PREFIX=$BOT_PREFIX
export SESSION_ID=$SESSION_ID
export GOOGLE_API_KEY=$GOOGLE_API_KEY
export WEATHER_API_KEY=$WEATHER_API_KEY
export MAL_USERNAME=$MAL_USERNAME
export MAL_PASSWORD=$MAL_PASSWORD

echo "Environment variables set successfully"

# Start the Nezuko bot
echo "Starting Bot"

yarn start
