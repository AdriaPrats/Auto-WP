#!/bin/bash

# Iniciem els contenidors
docker compose up -d

sleep 10

# Instalem WordPress
docker exec -u www-data -i wordpress wp core install --url=http://localhost:8000 --title="Prova" --admin_user=host --admin_password=mi_contraseña --admin_email=mi@email.com

# Activem el plugin d'importacio
#docker exec -u www-data -i wordpress wp plugin ../all-in-one-wp-migration.6.77.zip --activate
docker exec -u www-data -i wordpress wp plugin install /var/www/html/wp-content/plugins/all-in-one-wp-migration.6.77.zip --activate


# Passem la el backup a la carpeta per poder-lo restaurar
docker cp ./backup/divi.on-menu.com-20210913-072503-soo68c.wpress wordpress:/var/www/html/wp-content/

# wp ai1wm restore 
docker exec -u www-data -i wordpress wp ai1wm restore /var/www/html/wp-content/ai1wm-backups/divi.on-menu.com-20210913-072503-soo68c.wpress