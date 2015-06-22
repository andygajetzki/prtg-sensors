#!/bin/sh
echo "<prtg>"  

esxcli hpssacli cmd -q "ctrl all show" | sed -rn 's/.*Slot ([0-9] ).*)/\1/p' | while read -r CONTROLLER; 
  do      
    # check logical drives
    esxcli hpssacli cmd -q "ctrl slot=$CONTROLLER ld all show" | sed -rn 's/logicaldrive ([0-9^ ]{1}).*/\1/p' | while read -r LOGICALDRIVE; 
      do          
        echo "<result>"          
        echo " <channel>RAID: Logical drive $LOGICALDRIVE</channel>"          
        TMP=`esxcli hpssacli cmd -q "ctrl slot=$CONTROLLER ld $LOGICALDRIVE show"`          
        echo $TMP | grep -q "Status: OK"          
        if [ "$?" -eq 0 ] ; then              
          echo " <value>1</value>"          
        else              
          echo " <value>0</value>"          
        fi          
        echo " <ValueLookup>prtg.standardlookups.offon.stateonok</ValueLookup>"          
        echo "</result>"      
      done;
 
   # Check physical drives
    esxcli hpssacli cmd -q "ctrl slot=$CONTROLLER pd all show" | sed -rn 's/physicaldrive ([1-9]{1}[A-Z]{1}:[1-9]{1}:[1-9]{1})[^(].*/\1/p' | while read -r PHYSICALDRIVE; 
  do          
    echo "<result>"          
    echo " <channel>RAID: Physical drive $PHYSICALDRIVE</channel>"          
    TMP=`esxcli hpssacli cmd -q "ctrl slot=$CONTROLLER pd $PHYSICALDRIVE show"`          
    echo $TMP | grep -q "Status: OK"          
    if [ "$?" -eq 0 ] ; then              
      echo " <value>1</value>"          
    else              
      echo " <value>0</value>"          
    fi          
    echo " <ValueLookup>prtg.standardlookups.offon.stateonok</ValueLookup>"          
    echo "</result>"      
  done;  
done;  
echo "</prtg>"
