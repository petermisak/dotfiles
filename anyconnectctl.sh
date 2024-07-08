#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: $0 [on|off]"
	exit 1
fi

if [ "$1" = "off" ]; then
	echo "Quitting Cisco Secure Client - AnyConnect VPN Service"
	sudo /usr/bin/osascript -e 'quit app "Cisco Secure Client - AnyConnect VPN Service.app"'
	sudo /usr/bin/open -W -a "/opt/cisco/secureclient/bin/Cisco Secure Client - AnyConnect VPN Service.app" --args uninstall
	sudo launchctl bootout system /Library/LaunchDaemons/com.cisco.anyconnect.vpnagentd.plist
	echo "Deactivating Cisco Secure Client - Socket Filter Extension..."
	sudo "/Applications/Cisco/Cisco Secure Client - Socket Filter.app/Contents/MacOS/Cisco Secure Client - Socket Filter" -deactivateExt
elif [ "$1" = "on" ]; then
	echo "Starting Cisco Secure Client - AnyConnect VPN Service"
	sudo open -a "/opt/cisco/secureclient/bin/Cisco Secure Client - AnyConnect VPN Service.app"
else
	echo "Invalid option. Usage: $0 [on|off]"
	exit 1
fi
