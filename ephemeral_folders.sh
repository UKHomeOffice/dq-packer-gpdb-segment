#!/bin/bash
sudo su
# set base ownership of u01 and u02 to gpadmin
chown -R gpadmin:scriptrunners /u01/
chown -R gpadmin:scriptrunners /u02/
chmod -R u+w /u01
chmod -R u+w /u02

###########################################
# configure the directories and permissions
###########################################

#------------------------------------------
# /home/gpadmin directories
#------------------------------------------
su gpadmin
mkdir -p /home/gpadmin/GP_Shell_Scripts/log
mkdir -p /home/gpadmin/app_scripts/prod/partition_maintenance
exit
find /home/gpadmin/GP_Shell_Scripts -type f -exec chmod -R 775 {} \;
find /home/gpadmin/app_scripts/prod/partition_maintenance -type f -exec chmod -R 775 {} \;


#------------------------------------------
# /home/wherescape directories
#------------------------------------------
su wherescape
mkdir -p /home/wherescape/prod
mkdir -p /home/wherescape/gpAdminLogs
exit
chown -R wherescape:scriptrunners /home/wherescape/prod
chown -R wherescape:scriptrunners /home/wherescape/gpAdminLogs
find /home/wherescape/ -type f -exec chmod -R 664 {} \;


#------------------------------------------
# /gpdb/ directories
#------------------------------------------
su gpadmin
mkdir -p /gpdb/master/backups
mkdir -p /gpdb/master/backups_NRT
mkdir -p /gpdb/master/backups_NRT/db_dumps
mkdir -p /gpdb/master/backups_NRT/GP_DUMP
mkdir -p /gpdb/master/backups_rpt_ext
mkdir -p /gpdb/master/gpcrondump_backups
mkdir -p /gpdb/master/gpcrondump_backups_NRT
mkdir -p /gpdb/master/gpcrondump_backups_rpt_ext
exit
find /gpdb/master -type d -exec chmod 775 {} \;
find /gpdb/master/gpcrondump_backups_NRT -type f -exec chmod -R 700 {} \;
find /gpdb/master/gpcrondump_backups_rpt_ext -type f -exec chmod -R 700 {} \;


#------------------------------------------
# /u01/ directories
#------------------------------------------
chown -R wherescape:scriptrunners /u01/EF
chown -R gpadmin:gpadmin /u01/EF/data
chown -R wherescape:scriptrunners /u01/wherescape_data/
find /u01/EF -type d -exec chmod 777 {} \;
find /u01/EF -type f -exec chmod 755 {} \;
find /u01/wherescape_data -type d -exec chmod 755 {} \;
find /u01/wherescape_data -type f -exec chmod 755 {} \;

#------------------------------------------
# /u02/ directories
#------------------------------------------
chown -R gpadmin:scriptrunners /u02/carrier_portal_export/
chown -R wherescape:scriptrunners /u02/nbtc
chown -R gpadmin:scriptrunners /u02/nbtc/data
chown -R wherescape:scriptrunners /u02/s4
chown -R wherescape:scriptrunners /u02/ssm
chown -R gpadmin:scriptrunners /u02/ssm/data
chown -R gpadmin:scriptrunners /u02/ssm/scripts
find /u02/carrier_portal_export -type d -exec chmod -R 775 {} \;
find /u02/carrier_portal_export -type f -exec chmod -R 775 {} \;
find /u02/nbtc -type d -exec chmod -R 775 {} \;
find /u02/nbtc -type f -exec chmod -R 775 {} \;
find /u02/s4 -type d -exec chmod -R 775 {} \;
find /u02/s4 -type f -exec chmod -R 775 {} \;
find /u02/ssm -type d -exec chmod -R 775 {} \;
find /u02/ssm -type f -exec chmod -R 775 {} \;
