#! /usr/bin/bash

YELO='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # no color

function quickMenu {
	echo "-Quick Menu-"
	echo ""
	adb devices
	echo ""
	echo "C) Quick Connect (192.168.43.1)"
	echo "D) Disconnect"
	echo "I) Connect to custom IP"
	echo "R) Refresh Device Listing"
	echo ""
	read -p "> " executionInput

	executionInput=$(echo "$executionInput" | tr '[:upper:]' '[:lower:]')

	if [ "$executionInput" = "c" ]; then
		clear
		echo "Attempting Connection..."
		if timeout 5 adb connect 192.168.43.1; then
			echo -e "${GREEN}Connected successfully.${NC}"

		else
			echo -e "${RED}Connection attempt timed out or failed.${NC}"

		fi

		echo ""
		quickMenu

	elif [ "$executionInput" = "d" ]; then
		clear
		disconnectOutput=$(adb disconnect)
        echo -e "${YELLOW}${disconnectOutput}${NC}"
		echo ""
		quickMenu

	elif [ "$executionInput" = "i" ]; then
		clear
		customIp

	elif [ "$executionInput" = "r" ]; then
		clear
		echo -e "${YELO}Devices Refreshed.${NC}"
		quickMenu

	else
		clear
		echo -e "${RED}Invalid Input.${NC}"
		echo ""
		quickMenu

	fi
}

function customIp {
	echo "-Custom IP Menu-"
	echo ""
	adb devices
	echo ""
	echo "Please enter your desired IP address."
	echo ""
	echo "Extra Controls:"
	echo "D) Disconnect"
	echo "R) Refresh device listing"
	echo "X) Quit"
	echo ""
	read -p "> " ipAddress
	ipAddress=$(echo "$ipAddress" | tr '[:upper:]' '[:lower:]')

	if [ "$ipAddress" != "x" -a "$ipAddress" != "d" -a "$ipAddress" != "r" ]; then
		clear
		echo "Attempting to connect to $ipAddress..."

		if timeout 5 adb connect $ipAddress; then
			echo -e "${GREEN}Connected successfully.${NC}"

		else
			echo -e "${RED}Connection attempt timed out or failed.${NC}"

		fi

		echo ""
		customIp

	elif [ "$ipAddress" = "x" ]; then
		clear
		quickMenu

	elif [ "$ipAddress" = "d" ]; then
		clear
		disconnectOutput=$(adb disconnect)
        echo -e "${YELO}${disconnectOutput}${NC}"
		echo ""
		customIp

	elif [ "$ipAddress" = "r" ]; then
		clear
		echo -e "${YELO}Devices Refreshed.${NC}"
		customIp

	else
		clear
		echo -e "${RED}Invalid Input.${NC}"
		echo ""
		customIp
	fi
}

adb devices
clear

quickMenu
