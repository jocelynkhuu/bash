#!/bin/bash

# Script to update hostname on Mac if HostName does not match LocalHostName

get_hostname=$(scutil --get HostName)
get_localhostname=$(scutil --get LocalHostName)

if [[ "$get_hostname" != "$get_localhostname" ]]; then
    echo "HostName $get_hostname does not match LocalHostName $get_localhostname"
    scutil --set HostName $(scutil --get LocalHostName)
fi