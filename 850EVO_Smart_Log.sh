#!/bin/bash
#Reads and converts the output data "data_units_written" to gigabytes
WRITTEN=$(sudo smartctl -a /dev/sda | grep "241")
#IFS=': '
STRINGWRITTEN=( $WRITTEN )

WRITTENUNITS="$(echo "${STRINGWRITTEN[9]}")"
declare -i WRITTENUNITSCLEAN
WRITTENUNITSCLEAN=$(echo "${STRINGWRITTEN[9]}")
declare -i WRITTENUNITSCONV1
WRITTENUNITSCONV1=$WRITTENUNITSCLEAN*512
declare -i WRITTENUNITSCONV2
WRITTENUNITSCONV2=$WRITTENUNITSCONV1/1073741824

#unsafe shutdowns

UNSAFE=$(sudo smartctl -a /dev/sda | grep "235")
STRINGUNSAFE=( $UNSAFE )
declare -i UNSAFEUNITS
UNSAFEUNITS="$(echo "${STRINGUNSAFE[9]}")"

#temperature

TEMP=$(sudo smartctl -a /dev/sda | grep "190")
STRINGTEMP=( $TEMP )
declare -i TEMPUNITS
TEMPUNITS="$(echo "${STRINGTEMP[9]}")"

#Results

#defines red color

COLOR1='\033[1;32m'
COLOR2='\033[1;31m'
NC='\033[0m' 

if [ $WRITTENUNITSCONV2 -gt 150000 ]
then
echo -e "Written data units are ${COLOR2}$WRITTENUNITSCONV2 gigabytes${NC} and it is not cover by manufacters warranty(200 TBW)." 
else
echo -e "Written data units are ${COLOR1}$WRITTENUNITSCONV2 gigabytes${NC} and it is cover by manufacters warranty (200 TBW)." 
fi


if [ $TEMPUNITS -lt 70 ] && [ $TEMPUNITS -gt 0 ]
then
echo -e "Temperature 1 is ${COLOR1}$TEMPUNITS celsius${NC} and is between the correct working range."
else
echo -e "Temperature 1 is ${COLOR2}$TEMPUNITS celsius${NC} and is outside the correct working range."
fi

echo -e "The number of unsafe shutdowns is ${COLOR1}$UNSAFEUNITS.${NC}"

/bin/bash
