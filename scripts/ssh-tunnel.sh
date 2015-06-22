#!/bin/bash
CONTROLMASTER=<path_to_your_ssh_control_master>
HOST=<ssh_destination>
ssh -o ControlPath=$CONTROLMASTER -O check $HOST > /dev/null 2>&1

if [ "$?" -eq 255 ]
then
    echo '2:0:DOWN'
else
   echo '0:0:OK'
fi
