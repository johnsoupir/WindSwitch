#!/bin/bash




if [ $# -lt 2 ]; then
	echo "___________WELCOME TO WINDSWITCH___________"
	echo ""
	echo "Windswitch is a tool for automatically   " 
	echo "switching to random Windscibe servers.   " 
	echo "" 
	echo "The delay between changing servers can be"
	echo "set manually, or can be random.          "
	echo "Region can also be set manually or to    "
	echo "random.                                  "
	echo "" 
	echo "For faster usage you can start Windswitch"
	echo "with $0 <region> <time>"
	echo "Where <region> is a country code found in"
	echo "the second column of the server list     "
	echo "(displayed by typing \"windscribe locations\")"
	echo "and <time> is how long to wait between   "
	echo "changing locations in minutes.           "
	echo "Use r to specify random for time (30-300 "
        echo "minutes) and/or region."
	echo ""
	echo "Example: $0 US 60"
	echo "will connect to a random US server every"
	echo "60 minutes (1 hour)."
	echo ""
	echo "Example: $0 r r"
	echo "will connect to a random server in a random"
	echo "region, and change servers after a random"
	echo "ammount of time (between 30 and 300 minutes)"
	echo "___________________________________________"
	echo ""
	echo "Which region would you like to use?"
	echo "Enter a country code found in the second column of the server list (displayed by typing \"windscribe locations\""
	echo "or use r for random."
	echo ""
	echo "Enter region and press enter:"
	read $1
	echo ""
	echo "How long should Windswitch wait between switching locations?"
	echo "Enter the time in minutes, or use r for random (between 30 and 300)."
	echo ""
	echo "Enter time and press enter:"
	read $2

fi






if [ "$1" = "r" ]; then
	echo "REGION SET TO RANDOM"
	REGION=""
else
	echo "REGION SET TO $1"
	REGION=$1
fi


if [ "$2" = "r" ]; then
	echo "TIMER SET TO RANDOM"
	DELAY=$(($RANDOM%300+30))
else
	echo "TIMER SET TO $2"
	DELAY=$2
fi



clear
echo "__________________________STARTING WINDSWITCH__________________________"
delay=$1
echo "Windswitch will change servers every $2 minute(s)"
echo "Press Crtl+C to exit."
windscribe locations | grep "$REGION" | sed 's/  \+/,/g' | awk -F , '{ print $4 }' > locations.dat

function change_location {
SERVER=$(sort -R locations.dat | head -1)
echo "Connecting to $SERVER"
windscribe connect "$SERVER"
}

while [ 1 ] 
do
change_location
sleep ""$DELAY"m"

done



