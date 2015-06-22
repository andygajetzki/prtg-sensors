if [ -f /var/run/reboot-required ]  
then  
    echo '2:0:REBOOT REQUIRED' 
else 
   echo '0:0:OK'
fi
