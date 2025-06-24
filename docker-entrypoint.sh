#!/bin/bash
set -e

# Wait for MySQL to be ready
echo "Waiting for MySQL at $DB_HOST:${DB_PORT:-3306}"
while ! mysqladmin ping -h"$DB_HOST" -P"${DB_PORT:-3306}" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    echo "MySQL is unavailable - sleeping"
    sleep 2
done

echo "MySQL is up - executing migrations"
python manage.py migrate

echo "Starting Django server"
exec python manage.py runserver 0.0.0.0:8080