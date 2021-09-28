#!/bin/bash

# Short script to run Google Macops' DeprecationNotifier after it is deployed as an .app and remove if version is up-to-date
# DeprecationNotifier: https://github.com/google/macops

VERSION=$(sw_vers -productVersion)
dp_path=/Applications/DeprecationNotifier.app
latest_version="11.6"

if [[ $VERSION = "$latest_version" ]]; then
    if pgrep DeprecationNotifier && [ -x "$dp_path" ]; then
        pkill DeprecationNotifier && sudo rm -rf "$dp_path"
    else
        if [ -x "$dp_path" ]; then
            sudo rm -rf "$dp_path"
        fi
    fi
else
    if [ -x "$dp_path" ] && [[ $VERSION != "$latest_version" ]]; then
        /usr/bin/open "$dp_path"
    fi
fi
