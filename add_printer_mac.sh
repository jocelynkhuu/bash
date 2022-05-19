#!/usr/bin/env bash

# Short script for adding single printer using IP address on Mac


PRINTER_NAME="NAME_OF_PRINTER"
PRINTER_LOCATION="LOCATION_OF_PRINTER"
IP_ADDRESS="lpd://192.168.x.x"
DRIVER="/System/Library/Frameworks/ApplicationServices.framework/Frameworks/PrintCore.framework/Resources/Generic.ppd"


cat << "EOF"

    ________________
  _/_______________/|
 /___________/___//||
|===        |----| ||  I keep hearing music come from the printer. 
|           |   �| ||  I think the paper is jammin'!
|___________|   �| ||
| ||/.�---.||    | ||
|-||/_____\||-.  | |�
|_||=L==H==||_|__|/ 

EOF
echo "Hello! Looks like you're here to add a printer!"
read -p "Press enter/return to continue "
echo "Adding printer!"
echo ""
if /usr/sbin/lpadmin -p ${PRINTER_NAME} -L ${PRINTER_LOCATION} -E -v ${IP_ADDRESS} -P ${DRIVER} ; then
	echo ""
	echo "Printer added!"
	
cat << "EOF"
	
	
	 _    _     __      ________               _____ _____  ______       _______
	| |  | |   /\ \    / /  ____|     /\      / ____|  __ \|  ____|   /\|__   __|
	| |__| |  /  \ \  / /| |__       /  \    | |  __| |__) | |__     /  \  | |
	|  __  | / /\ \ \/ / |  __|     / /\ \   | | |_ |  _  /|  __|   / /\ \ | |
	| |  | |/ ____ \  /  | |____   / ____ \  | |__| | | \ \| |____ / ____ \| |
	|_|  |_/_/    \_\/   |______| /_/    \_\  \_____|_|  \_\______/_/    \_\_|
	
	
	 _____      __     ___
	|  __ \   /\\ \   / / |
	| |  | | /  \\ \_/ /| |
	| |  | |/ /\ \\   / | |
	| |__| / ____ \| |  |_|
	|_____/_/    \_\_|  (_)
	
EOF
	
else
	echo "Printer was not added :( Please try manually adding the printer instead. Please see xxxxx for more details"
fi
echo ""
echo "Please close this window."

