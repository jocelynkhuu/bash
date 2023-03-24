#!/usr/bin/env bash

# Script to pop up a dialog box once a week to track dates for appointments in a txt file.

scriptPath='/Users/Shared/askdate.sh'

cat << "EOF" > "$scriptPath"
button=$(osascript -e 'tell application "System Events" to display dialog "Did you have an appointment this week?" buttons {"Yes", "No"} default button 2')

if [[ "$button" = "button returned:Yes" ]]; then
    dateInput=$(osascript -e 'tell application "System Events" to display dialog "Awesome! What date was your appointment?" default answer "xx/xx/xxxx" buttons {"OK"} default button 1')
    echo $dateInput | awk -F "[:]" '{print $NF}' >> ~/.appointmentdates.csv
    sessionNumber=$(cat ~/.appointmentdates.csv | wc -l)
totalSessions=$(osascript << EOS 
button returned of (display dialog "You've had $sessionNumber appointments as of today. Would you like to delete the file?" buttons {"Yes", "No"} default button 2)
EOS
)
    if [[ "$totalSessions" = "Yes" ]]; then
        rm ~/.appointmentdates.csv
    fi
fi
EOF


##### LAUNCHAGENT #####
laPath=$HOME'/Library/LaunchAgents/com.track.dates.plist'

ldLabel=$(basename "$laPath" | sed 's/.plist//')

#Check if LA exists already, boot it out, and delete it
if [[ -f "$laPath" ]]; then
	/bin/launchctl bootout system "$laPath" 2>/dev/null
	rm -f "$laPath"
fi

cat << EOF > "$laPath"
<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"> 
<plist version="1.0"> 
<dict> 
	<key>Label</key> 
	<string>$(basename "$laPath" | sed 's/.plist//')</string> 
	<key>ProgramArguments</key> 
	<array> 
		<string>/bin/bash</string> 
		<string>$scriptPath</string> 
	</array> 
	<key>RunAtLoad</key> 
	<true/>
	<key>StartCalendarInterval</key>
	<dict>
        <key>Hour</key>
        <integer>22</integer>
        <key>Weekday</key>
        <integer>6</integer>
	</dict>
</dict> 
</plist>
EOF

#"Load" the job
/bin/launchctl bootstrap system "$laPath"
