#!/bin/bash

SITE_ROOT=/train/sites

checkSite() {
  if [ -f $1/$2/monitor_phrase ]; then
    OUT="<result>"
    OUT+="<channel>Website: $2</channel>"
    curl -s $2 | tac | grep -q -f $1/$2/monitor_phrase;
    if [ "$?" -eq 0 ]; then
      OUT+="<value>0</value>"
    else 
      OUT+="<value>1</value>"
    fi;
    OUT+="<ValueLookup>prtg.standardlookups.offon.stateoffok</ValueLookup>"
    OUT+="</result>"
    echo $OUT
  fi;
}
export -f checkSite

echo "<prtg>"

for i in `ls $SITE_ROOT`; do 
  printf "%s\0%s\0" "$SITE_ROOT" "$i" 
done | xargs -0 -n 2 -P 50 bash -c 'checkSite "$@"' --

echo "</prtg>"
