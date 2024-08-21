FROM python:3.9-slim
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    nginx \
    certbot \
    python3-certbot-nginx \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar archivos de la aplicación
COPY . .

# Configurar Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Preparar el script de entrada
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Exponer puertos
EXPOSE 80 443

# Configurar el punto de entrada
ENTRYPOINT ["/app/entrypoint.sh"]

# Modificar el comando para iniciar tanto Gunicorn como Nginx
CMD ["sh", "-c", "nginx && gunicorn --bind 0.0.0.0:8000 AyniAPI.wsgi:application"]
