# prtg-sensors

## advanced ssh sensors (returns more than one result)
* ssh-advanced/apc.sh - returns APC UPS values and status, including line voltage, load, and time remaining on battery backup
* ssh-advanced/hpsa.sh - returns RAID status for HPSA controllers
* ssh-advanced/smart.sh - returns independent drive SMART status
* ssh-advanced/sites.sh - checks HTTP sites for a specific value in the HTML server. If you have a directory of vhosts, create a file called 'monitor_phrase' at the root directory of the vhost. The HTML response from the site must return content containing this phrase or the sensor fails. Ber sure to set a high timeout for the command if you have many sites. Set SITE_ROOT to the base directory of your vhosts.
## simple ssh sensors (return a single result)
* ssh-simple/reboot-required.sh - determines if a reboot is required on a Ubuntu or Debian system