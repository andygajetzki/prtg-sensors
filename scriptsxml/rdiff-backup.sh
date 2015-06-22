#!/bin/bash

BACKUP_ROOT="/srv/backups/fs/rdiff"       # The root ditrectory containing your backup destinations
MAX_AGE_IN_SECONDS=43200                  # 12 hours or 43200 seconds

export BACKUP_ROOT MAX_AGE_IN_SECONDS

checkBackup() {


  # Check for stale backups
  OUT="<result>"
  OUT+="<channel>Backup Age: $2</channel>" 
  TIMESTAMP=`echo "$RDIFF_INFO" | tail -n +3 | head -1 | cut -c 1-25`
  DATE_NOW=`date +"%s"`
  DATE_THEN=`ls -Art $1/$2/rdiff-backup-data/session* | tail -n 1 | xargs cat  |  grep EndTime | cut -d' ' -f 2 | xargs printf "%.0f"`
  DATE_DIFF=$((DATE_NOW-DATE_THEN))
  OUT+="<Value>$DATE_DIFF</Value>"
  OUT+="<LimitMode>1</LimitMode>"
  OUT+="<LimitMaxError>$MAX_AGE_IN_SECONDS</LimitMaxError>"
  OUT+="<CustomUnit>Seconds</CustomUnit>"
  OUT+="<ValueLookup>prtg.standardlookups.offon.stateoffok</ValueLookup>"
  OUT+="</result>"

  # Size of archives
  SIZE_BYTES=`ls -Art $1/$2/rdiff-backup-data/session* | tail -n 1 | xargs cat  |  grep MirrorFileSize | cut -d' ' -f 2`
  SIZE_MB=$((SIZE_BYTES/1048576))

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
