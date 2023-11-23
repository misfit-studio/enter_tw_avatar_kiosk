#!/bin/bash

# GitHub repo details
OWNER="misfit-studio"
REPO="enter_tw_avatar_kiosk"

# Local version file
LOCAL_VERSION_FILE="/home/pi/version.txt"

# Preconfigured command to run after update
RUN_COMMAND="flutter-pi --videomode 1280x720 --orientation portrait_up --release /home/pi/flutter_assets/"

# Function to compare versions
version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

# Function to run the preconfigured command
run_command() {
    while true; do
        $RUN_COMMAND
        echo "Process exited. Restarting in 5 seconds..."
        sleep 5
    done
}

# Fetch the latest release data from GitHub
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/latest")

# Extract the tag name (version) and zip URL from the release data
LATEST_VERSION=$(echo $LATEST_RELEASE | jq -r '.tag_name')
ZIP_URL=$(echo $LATEST_RELEASE | jq -r '.assets[0].browser_download_url')

# Read the local version
if [ -f "$LOCAL_VERSION_FILE" ]; then
    LOCAL_VERSION=$(cat "$LOCAL_VERSION_FILE")
else
    LOCAL_VERSION="0.0.0"
fi

# Compare versions and download if newer
if version_gt $LATEST_VERSION $LOCAL_VERSION; then
    echo "New version available: $LATEST_VERSION. Downloading..."
    curl -L $ZIP_URL -o "./release.zip"
    unzip -o "./release.zip" -d "."
    echo $LATEST_VERSION > "$LOCAL_VERSION_FILE"
    echo "Update complete."
else
    echo "You are up to date. Current version: $LOCAL_VERSION."
fi

run_command &  # Run the command in the background
