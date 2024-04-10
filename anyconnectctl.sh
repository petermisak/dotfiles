#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: $0 [on|off]"
	exit 1
fi

if [ "$1" = "off" ]; then
	echo "Disabling vpnagentd..."
	sudo launchctl disable system/com.cisco.anyconnect.vpnagentd
	echo "Tearing down vpnagentd..."
	sudo launchctl bootout system /Library/LaunchDaemons/com.cisco.anyconnect.vpnagentd.plist
	echo "Deactivating Cisco AnyConnect Socket Filter Extension..."
	/Applications/Cisco/Cisco\ AnyConnect\ Socket\ Filter.app/Contents/MacOS/Cisco\ AnyConnect\ Socket\ Filter -deactivateExt
elif [ "$1" = "on" ]; then
	echo "Enabling vpnagentd..."
	sudo launchctl enable system/com.cisco.anyconnect.vpnagentd
	echo "Bootstrapping vpnagentd..."
	sudo launchctl bootstrap system /Library/LaunchDaemons/com.cisco.anyconnect.vpnagentd.plist
else
	echo "Invalid option. Usage: $0 [on|off]"
	exit 1
fi
