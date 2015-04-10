# prtg-sensors

## advanced ssh sensors (returns more than one result)
* ssh-advanced/apc.sh - returns APC UPS values and status, including line voltage, load, and time remaining on battery backup
* ssh-advanced/hpsa.sh - returns RAID status for HPSA controllers
* ssh-advanced/smart.sh - returns independent drive SMART status
* ssh-advanced/rdiff-backup.ssh - checks the rdiff-backups in a backup directory root and fails if a certain duration has been exceeded. Useful to ensure that rdiff-backup is completing its backups. Also, returns an integer indicating the size of the backup in MB. No checking is done to ensure a backup doesn't decrease in size, however.
* ssh-advanced/sites.sh - checks HTTP sites for a specific value in the server response body. If you have a directory of vhosts, create a file called 'monitor_phrase' at the root directory of each vhost. The HTML response from the site must return content containing the contents of this file or the sensor fails. Be sure to set a high timeout for the command if you have many sites. Set SITE_ROOT to the base directory of your vhosts.

## simple ssh sensors (return a single result)
* ssh-simple/reboot-required.sh - determines if a reboot is required on a Ubuntu or Debian system