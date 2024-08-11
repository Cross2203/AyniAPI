#!/bin/sh

wait_for_db() {
  echo "Esperando a que la base de datos esté lista..."
  while ! nc -z $DB_HOST $DB_PORT; do
    echo "DB no está lista. Esperando..."
    sleep 2
  done
  echo "Base de datos lista!"
}

wait_for_db

echo "Ejecutando migraciones..."
python manage.py makemigrations
python manage.py migrate

echo "Iniciando la aplicación..."
exec "$@"