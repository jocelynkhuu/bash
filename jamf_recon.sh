#!/usr/bin/env bash

# Used to find logged in user and creates email to push into user & location field within JAMF

loggedInUser=$( ls -la /dev/console | cut -d " " -f 4 )

/usr/local/bin/jamf recon -endUsername $loggedInUser -email "$loggedInUser@petalcard.com"
