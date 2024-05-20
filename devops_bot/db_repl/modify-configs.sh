#!/bin/bash
set -Eeo pipefail

PGDATA="/var/lib/postgresql/data"

cat /tmp/standby.conf >> $PGDATA/postgresql.conf

export PATH=$PATH:/usr/lib/postgresql/15/bin/
pg_ctl stop -D $PGDATA
rm     -rf     $PGDATA/*


export PGPASSWORD=${DB_REPL_PASSWORD}
pg_basebackup -h ${DB_HOST} -D $PGDATA -U ${DB_REPL_USER} -P -v --wal-method=stream --write-recovery-conf
unset    PGPASSWORD

chown -R postgres:postgres $PGDATA
pg_ctl start -D $PGDATA
