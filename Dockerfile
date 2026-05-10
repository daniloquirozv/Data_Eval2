FROM mysql:8.0

# Variables de entorno para MySQL
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=proyecto_db
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Copiar script de inicialización de la base de datos
# MySQL ejecuta automáticamente los scripts en /docker-entrypoint-initdb.d/ al iniciar
COPY 01_creacion_base_datos.sql /docker-entrypoint-initdb.d/

# Copiar script de mantenimiento (para uso manual, no se ejecuta automáticamente)
COPY 02_backup_y_mantenimiento.sql /scripts/

# Configuración para permitir conexiones remotas
RUN echo "[mysqld]" > /etc/mysql/conf.d/custom.cnf && \
    echo "bind-address = 0.0.0.0" >> /etc/mysql/conf.d/custom.cnf

# Puerto por defecto de MySQL
EXPOSE 3306