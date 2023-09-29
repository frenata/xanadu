#!/bin/sh

DATA_DIR=/var/db/postgres/data15
COLD=false

if [ -z "$(ls -A $DATA_DIR)" ]; then
	service postgresql oneinitdb
	COLD=true
fi

cp /src/postgresql.conf $DATA_DIR/postgresql.conf
cp /src/pg_hba.conf $DATA_DIR/pg_hba.conf

if [ "$COLD" == "true" ]; then
	service postgresql start
else
	service postgresql restart
fi

psql -U postgres -c "alter user postgres password '${db_pass}'"
