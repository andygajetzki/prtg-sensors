# prtg-sensors

## advanced ssh sensors (returns more than one result)
* ssh-advanced/apc.sh - returns APC UPS values and status, including line voltage, load, and time remaining on battery backup
* ssh-advanced/hpsa.sh - returns RAID status for HPSA controllers
* ssh-advanced/smart.ch - returns independent drive SMART status

## simple ssh sensors (return a single result)
* ssh-simple/reboot-required.sh - determines if a reboot is required on a Ubuntu or Debian system