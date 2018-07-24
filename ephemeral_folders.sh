#!/bin/bash
mkdir -p /ephemeral/backups
mkdir -p /ephemeral/backups_NRT
mkdir -p /ephemeral/backups_NRT/db_dumps
mkdir -p /ephemeral/backups_NRT/GP_DUMP
mkdir -p /ephemeral/backups_rpt_ext
chown -R gpadmin:gpadmin /ephemeral/backups*
mkdir -p /ephemeral/gpcrondump_backups
mkdir -p /ephemeral/gpcrondump_backups_NRT
mkdir -p /ephemeral/gpcrondump_backups_rpt_ext
chown -R gpadmin:gpadmin /ephemeral/gpcron*
find /ephemeral/gpcrondump_backups_NRT -type f -exec chmod -R 700 {} \;
find /ephemeral/gpcrondump_backups_rpt_ext -type f -exec chmod -R 700 {} \;
