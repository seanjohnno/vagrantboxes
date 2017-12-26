#!/bin/bash

DB_CREATED=$(psql -c "SELECT usename FROM pg_user;" | grep mrserver)
if [ -z $DB_CREATED ]; then
	psql -c "CREATE ROLE mrserver NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;"
	psql -c "CREATE DATABASE mrserver OWNER mrserver;"
	psql -c "alter user mrserver with encrypted password 'password01';"
	
	cp /vagrant/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
	cp /vagrant/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
else
	echo "DB and user already created"
fi
