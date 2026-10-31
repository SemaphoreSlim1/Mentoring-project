#!/usr/bin/env bash
/opt/mssql/bin/sqlservr &
pid="$!"


echo "Waiting for SQL Server to start..."
until sqlcmd \
    -S localhost \
    -U SA \
    -C \
    -P "$MSSQL_SA_PASSWORD" \
    -Q "SELECT 1" >/dev/null 2>&1
do
    sleep 2
done

if [ ! -f /var/opt/mssql/.initialized ]; then
    echo "Initializing database..."

    # Create database if it does not exist
    sqlcmd \
        -S localhost \
        -U SA \
        -C \
        -P "$MSSQL_SA_PASSWORD" \
        -Q "IF DB_ID(N'$DEFAULT_DATABASE') IS NULL CREATE DATABASE [$DEFAULT_DATABASE];"

    if [ -f /docker-init/migrations.sql ]; then
        # Run EF migrations against that database
        sqlcmd \
            -S localhost \
            -U SA \
            -C \
            -I \
            -P "$MSSQL_SA_PASSWORD" \
            -d "$DEFAULT_DATABASE" \
            -i /docker-init/migrations.sql
    fi

    touch /var/opt/mssql/.initialized
else
    echo "Database already initialized"
fi

wait "$pid"
