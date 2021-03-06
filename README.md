# prtg-sensors

## advanced ssh sensors (returns more than one result)
* scriptsxml/apc.sh - returns APC UPS values and status, including line voltage, load, and time remaining on battery backup
* scriptsxml/hpsa.sh - returns RAID status for HPSA controllers
* scriptsxml/postgres.sh - checks various postgres health properties (uses https://bucardo.org/wiki/Check_postgres). Extract check_postgres-<version>.tar.gz to /usr/share/check_postgres or adjust the path in the script.
* scriptsxml/rdiff-backup.ssh - checks the rdiff-backups in a backup directory root and fails if a certain duration has been exceeded. Useful to ensure that rdiff-backup is completing its backups. Also, returns an integer indicating the size of the backup in MB. No checking is done to ensure a backup doesn't decrease in size, however.
* scriptsxml/sites.sh - checks HTTP sites for a specific value in the server response body. If you have a directory of vhosts, create a file called 'monitor_phrase' at the root directory of each vhost. The HTML response from the site must return content containing the contents of this file or the sensor fails. Be sure to set a high timeout for the command if you have many sites. Another file at your vhost root, 'monitor_hosts' must be populated with a listed of domain names (one per line) that will be checked for the contents of 'monitor_phrase'. A failure in any host in the list will fail the sensor. Set SITE_ROOT to the base directory of your vhosts.
* scriptsxml/smart.sh - returns independent drive SMART status


## simple ssh sensors (return a single result)
* scripts/reboot-required.sh - determines if a reboot is required on a Ubuntu or Debian system
* scripts/ssh-tunnel.sh - checks an ssh control master for a connection to a host