#!/bin/bash

SITE_ROOT=/srv/sites

checkSite() {
  if [ -f $1/$2/monitor_phrase ]; then
    OUT+="<result>"
    for HOST in $(cat $1/$2/monitor_hosts); do
      
      OUT+="<channel>Website: $2/$HOST</channel>"
      curl -s -L  $HOST | tac | grep -q -f $1/$2/monitor_phrase;
      if [ "$?" -eq 0 ]; then
        OUT+="<value>1</value>"
      else 
        OUT+="<value>0</value>"
	ERROR="<Error>1</Error>"
      fi;
      OUT+="<ValueLookup>prtg.standardlookups.offon.stateonok</ValueLookup>"
    done; 
    OUT+="</result>"
    
    echo $OUT
    echo $ERROR
  fi;
}
export -f checkSite

echo "<prtg>"
for i in `ls $SITE_ROOT`; do 
  printf "%s\0%s\0" "$SITE_ROOT" "$i" 
done | xargs -0 -n 2 -P 50 bash -c 'checkSite "$@"' --

echo "</prtg>"
