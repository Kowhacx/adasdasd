#!/bin/bash

main() {
    clear
    echo -e "Welcome to the MacSploit Experience!"
    echo -e "Install Script Version 2.6"

    # Prepare jq for parsing JSON data
    echo -ne "Preparing Installation..."
    curl -s "https://git.raptor.fun/main/jq-macos-amd64" -o "./jq"
    chmod +x ./jq
    
    # Skipping License Key and Roblox installation steps

    # Download MacSploit
    echo -e "Downloading MacSploit..."
    curl "https://git.raptor.fun/main/macsploit.zip" -o "./MacSploit.zip"

    # Install MacSploit
    echo -n "Installing MacSploit... "
    unzip -o -q "./MacSploit.zip"
    echo -e "Done."

    # Update dylib for MacSploit
    echo -n "Updating Dylib..."
    curl -Os "https://git.raptor.fun/main/macsploit.dylib"
    echo -e " Done."

    # Patch Roblox
    echo -e "Patching Roblox..."
    mv ./macsploit.dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"
    mv ./libdiscord-rpc.dylib "/Applications/Roblox.app/Contents/MacOS/libdiscord-rpc.dylib"
    ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"
    rm ./insert_dylib

    # Install MacSploit App
    echo -n "Installing MacSploit App... "
    [ -d "/Applications/MacSploit.app" ] && rm -rf "/Applications/MacSploit.app"
    mv ./MacSploit.app /Applications/MacSploit.app
    rm ./MacSploit.zip
    
    # Save version information
    touch ~/Downloads/ms-version.json
    local versionInfo=$(curl -s "https://git.raptor.fun/main/version.json")
    echo $versionInfo > ~/Downloads/ms-version.json
    
    echo -e "Done."
    echo -e "Install Complete! Developed by Nexus42!"
    exit
}

main
