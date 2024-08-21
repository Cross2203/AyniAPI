#!/bin/bash
set -e

# Configura estas variables
DOMAIN_NAME="ayniapp.zapto.org"
EMAIL_ADDRESS="tu-email@ejemplo.com"

wait_for_db() {
  echo "Esperando a que la base de datos esté lista..."
  while ! nc -z $DB_HOST $DB_PORT; do
    echo "DB no está lista. Esperando..."
    sleep 2
  done
  echo "Base de datos lista!"
}

setup_ssl() {
  if [ ! -f /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem ]; then
    echo "Obteniendo certificado SSL..."
    certbot certonly --standalone -d ${DOMAIN_NAME} --non-interactive --agree-tos -m ${EMAIL_ADDRESS} --debug-challenges || {
      echo "Error al obtener el certificado SSL. Mostrando logs de Certbot:"
      cat /var/log/letsencrypt/letsencrypt.log
      return 1
    }
    
    echo "Actualizando configuración de Nginx..."
    sed -i "s|# listen 443 ssl;|listen 443 ssl;|g" /etc/nginx/nginx.conf
    sed -i "s|# ssl_certificate|ssl_certificate|g" /etc/nginx/nginx.conf
    sed -i "s|# ssl_certificate_key|ssl_certificate_key|g" /etc/nginx/nginx.conf
    sed -i "s|YOUR_EC2_PUBLIC_DNS|${DOMAIN_NAME}|g" /etc/nginx/nginx.conf
  else
    echo "Certificado SSL ya existe."
  fi
}

echo "Iniciando script de entrada..."
wait_for_db

echo "Configurando SSL..."
if ! setup_ssl; then
  echo "La configuración SSL falló. Continuando sin SSL..."
fi

echo "Ejecutando migraciones..."
python manage.py makemigrations
python manage.py migrate

echo "Iniciando la aplicación..."
exec "$@"
