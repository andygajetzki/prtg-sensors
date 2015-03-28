#!/bin/bash

TEMP="/tmp/$(basename $0).$$.tmp"
/sbin/apcaccess > $TEMP

declare -A VALUES
while read LINE; do
      NAME=`echo $LINE | cut -d ':' -f 1 |  sed 's/^[ \t]*//;s/[ \t]*$//'`
      VAL=`echo $LINE | cut -d ':' -f 2 |  sed 's/^[ \t]*//;s/[ \t]*$//'`
      VALUES[$NAME]=$VAL
done < $TEMP

echo "<prtg>"

# STATUS
echo "<result>"
echo "<channel>APC Status</channel>"
if [ "${VALUES['STATUS']}" = "ONLINE" ]; then
    echo "<value>1</value>"
else
    echo "<value>0</value>"
fi
echo "<ValueLookup>prtg.standardlookups.offon.stateonok</ValueLookup>"
echo "</result>"

# LINEV 
echo "<result>"
echo "<channel>APC Line Voltage</channel>"
echo "<value>${VALUES['LINEV']//[A-Za-z ]}</value>"
echo "<CustomUnit>Volts</CustomUnit>"
echo "<Float>1</Float>"
# Set max value to HITRANS and min value to LOTRANS
echo "<LimitMode>1</LimitMode>"
echo "<LimitMinError>${VALUES['LOTRANS']//[A-Za-z ]}</LimitMinError>"
echo "<LimitMaxError>${VALUES['HITRANS']//[A-Za-z ]}</LimitMaxError>"
echo "</result>"

# LOADPCT
echo "<result>"
echo "<channel>APC Load</channel>"
echo "<value>${VALUES['LOADPCT']//[A-Za-z ]}</value>"
echo "<CustomUnit>%</CustomUnit>"
echo "<Float>1</Float>" 
echo "</result>"

# BCHARGE
echo "<result>"
echo "<channel>APC Battery Charge</channel>"
echo "<value>${VALUES['BCHARGE']//[A-Za-z ]}</value>"
echo "<CustomUnit>%</CustomUnit>"
echo "<Float>1</Float>"
echo "</result>"

# TIMELEFT
echo "<result>"
echo "<channel>APC Time Left</channel>"
echo "<value>${VALUES['TIMELEFT']//[A-Za-z ]}</value>"
echo "<CustomUnit>Minutes</CustomUnit>"
echo "<Float>1</Float>"
echo "<LimitMode>1</LimitMode>" 
echo "<LimitMinError>${VALUES['MINTIMEL']//[A-Za-z ]}</LimitMinError>"
echo "</result>"

# BATTDATE
echo "<result>"
echo "<channel>APC Battery Manufacture Date</channel>"
echo "<value>${VALUES['BATTDATE']}</value>"
echo "</result>"


echo "</prtg>"
 
