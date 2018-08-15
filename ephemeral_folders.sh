#------------------------------------------
# /gpdb/ directories
#------------------------------------------
mkdir -p /gpdb/master/backups
mkdir -p /gpdb/master/backups_NRT
mkdir -p /gpdb/master/backups_NRT/db_dumps
mkdir -p /gpdb/master/backups_NRT/GP_DUMP
mkdir -p /gpdb/master/backups_rpt_ext
mkdir -p /gpdb/master/gpcrondump_backups
mkdir -p /gpdb/master/gpcrondump_backups_NRT
mkdir -p /gpdb/master/gpcrondump_backups_rpt_ext
chown -R gpadmin:gpadmin /gpdb
find /gpdb/master -type d -exec chmod 775 {} \;
find /gpdb/master/gpcrondump_backups_NRT -type f -exec chmod -R 700 {} \;
find /gpdb/master/gpcrondump_backups_rpt_ext -type f -exec chmod -R 700 {} \;
