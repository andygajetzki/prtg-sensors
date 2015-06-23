#!/bin/bash

# Please see check_postgres man page for the actions you want to check
ACTIONS="archive_ready autovac_freeze backends bloat commitratio connection disabled_triggers disk_space hitratio  last_analyze last_autoanalyze last_autovacuum last_vacuum prepared_txns same_schema sequence timesync wal_files"


checkAction() {

    OUT="<result>"
    OUT+="<channel>$1</channel>"
    sudo -iu postgres /usr/share/check_postgres/check_postgres.pl --action $1 > /dev/null

    if [ "$?" -eq 0 ]; then
      OUT+="<value>0</value>"
    else
      OUT+="<value>1</value>"
    fi;
    OUT+="<ValueLookup>prtg.standardlookups.offon.stateoffok</ValueLookup>"
    OUT+="</result>"
    echo $OUT

}
export -f checkAction

echo "<prtg>"
for ACTION in $ACTIONS;
do
    printf "%s\0" "$ACTION"
done | xargs -0 -n 1 -P 50 bash -c 'checkAction "$@"' --

echo "</prtg>"

