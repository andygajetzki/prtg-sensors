#!/bin/bash

BACKUP_ROOT="/srv/backups/fs/rdiff"       # The root ditrectory containing your backup destinations
RDIFF_BACKUP="/usr/bin/rdiff-backup"
MAX_AGE_IN_SECONDS=43200                  # 12 hours or 43200 seconds

export BACKUP_ROOT RDIFF_BACKUP MAX_AGE_IN_SECONDS

checkBackup() {


  RDIFF_INFO=$($RDIFF_BACKUP --list-increment-sizes $BACKUP_ROOT/$2)

  # Check for stale backups
  OUT="<result>"
  OUT+="<channel>Backup Age: $2</channel>" 
  TIMESTAMP=`echo "$RDIFF_INFO" | tail -n +3 | head -1 | cut -c 1-25`
  DATE_NOW=`date +"%s"`
  DATE_THEN=`date +"%s" --date="$TIMESTAMP"`
  DATE_DIFF=`expr $DATE_NOW - $DATE_THEN`
  OUT+="<Value>$DATE_DIFF</Value>"
  OUT+="<LimitMode>1</LimitMode>"
  OUT+="<LimitMaxError>$MAX_AGE_IN_SECONDS</LimitMaxError>"
  OUT+="<CustomUnit>Seconds</CustomUnit>"
  OUT+="<ValueLookup>prtg.standardlookups.offon.stateoffok</ValueLookup>"
  OUT+="</result>"

  # Size of archives
  SIZE_HUMAN=`echo "$RDIFF_INFO" | tail -n +3 | head -1 | cut -c 25-45`
  SIZE_MB=`units -1t -o "%f" "$SIZE_HUMAN" MB`

  OUT+="<result>"
  OUT+="<channel>Size: $2</channel>"
  OUT+="<Value>${SIZE_MB%.*}</Value>"
  OUT+="<CustomUnit>MB</CustomUnit>"
  OUT+="</result>"

  

  echo $OUT
}
export -f checkBackup

echo "<prtg>"

for i in `ls $BACKUP_ROOT`; do 
  printf "%s\0%s\0" "$BACKUP_ROOT" "$i" 
done | xargs -0 -n 2 -P 50 bash -c 'checkBackup "$@"' --

echo "</prtg>"
