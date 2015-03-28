#!/bin/sh

SMARTCTL="/usr/sbin/smartctl"

echo "<prtg>"
for DEVICE in `$SMARTCTL --scan-open | grep -o "^/dev/[a-z]*"`; do
  echo " <result>"
  echo "  <channel>SMART OK: $DEVICE</channel>"
  $SMARTCTL -H $DEVICE > /dev/null 2>&1
  if [ "$?" -eq 0 ]; then
    echo "  <value>1</value>"
  else
    echo "  <value>2</value>"
  fi;
  echo "  <ValueLookup>prtg.standardlookups.yesno.stateyesok</ValueLookup>"
  echo " </result>"
done;
echo "</prtg>"
