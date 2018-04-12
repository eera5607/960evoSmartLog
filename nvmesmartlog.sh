#!/bin/bash
#Reads and converts the output data "data_units_written" to gigabytes

WRITTEN=$(sudo nvme smart-log /dev/nvme0n1 | grep "data_units_written")
IFS=': '
STRINGWRITTEN=( $WRITTEN )

WRITTENUNITS="$(echo "${STRINGWRITTEN[1]}")"
declare -i WRITTENUNITSCLEAN
WRITTENUNITSCLEAN=$(echo "${STRINGWRITTEN[1]}" | sed 's/,//' | sed 's/,//')
declare -i WRITTENUNITSCONV1
WRITTENUNITSCONV1=$WRITTENUNITSCLEAN*512000
declare -i WRITTENUNITSCONV2
WRITTENUNITSCONV2=$WRITTENUNITSCONV1/1073741824

#Reads and converts the output data "data_units_read" to gigabytes

READ=$(sudo nvme smart-log /dev/nvme0n1 | grep "data_units_read")
STRINGREAD=( $READ )

READUNITS="$(echo "${STRINGREAD[1]}")"
declare -i READUNITSCLEAN
READUNITSCLEAN=$(echo "${STRINGREAD[1]}" | sed 's/,//' | sed 's/,//')
declare -i READUNITSCONV1
READUNITSCONV1=$READUNITSCLEAN*512000
declare -i READUNITSCONV2
READUNITSCONV2=$READUNITSCONV1/1073741824

#Retrieves info about unsafe shutdowns

UNSAFE=$(sudo nvme smart-log /dev/nvme0n1 | grep "unsafe_shutdowns")
STRINGUNSAFE=( $UNSAFE)
UNSAFEUNITS="$(echo "${STRINGUNSAFE[1]}")"

#Temperatures

TEMP=$(sudo nvme smart-log /dev/nvme0n1 | grep "Temperature Sensor 1")
STRINGTEMP=( $TEMP)
declare -i TEMPUNITS
TEMPUNITS="$(echo "${STRINGTEMP[3]}")"

TEMP2=$(sudo nvme smart-log /dev/nvme0n1 | grep "Temperature Sensor 2")
STRINGTEMP2=( $TEMP2)
declare -i TEMP2UNITS
TEMP2UNITS="$(echo "${STRINGTEMP2[3]}")"

#Results

#defines red color
COLOR1='\033[1;32m'
COLOR2='\033[1;31m'
NC='\033[0m' 

if [ $WRITTENUNITSCONV2 -gt 200000 ]
then
echo -e "Written data units are ${COLOR2}$WRITTENUNITSCONV2 gigabytes${NC} so the SSD not cover by Samsung's warranty anymore (200 Terabytes Written)." 
else
echo -e "Written data units are ${COLOR1}$WRITTENUNITSCONV2 gigabytes${NC} and SSD is still cover by Samsung's warranty (200 Terabytes Written)." 
fi

echo -e "Read data units are ${COLOR1}$READUNITSCONV2 gigabytes${NC}."


if [ $TEMPUNITS -lt 70 ] && [ $TEMPUNITS -gt 0 ]
then
echo -e "Temperature 1 is ${COLOR1}$TEMPUNITS celsius${NC} and is between the recommended working range."
else
echo -e "Temperature 1 is ${COLOR2}$TEMPUNITS celsius${NC} and is outside the recommended working range."
fi

if [ $TEMP2UNITS -lt 70 ] && [ $TEMP2UNITS -gt 0 ]
then
echo -e "Temperature 2 is ${COLOR1}$TEMP2UNITS celsius${NC} and is between the recommended working range."
else
echo -e "Temperature 2 is ${COLOR2}$TEMP2UNITS celsius${NC} and is outside the recommended working range."
fi 

echo -e "The number of unsafe shutdowns is ${COLOR1}$UNSAFEUNITS.${NC}"

/bin/bash
