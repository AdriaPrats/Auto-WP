#!/bin/bash

# Iniciem els contenidors
docker compose up -d

sleep 10

# Instalem WordPress
docker exec -u www-data -i wordpress wp core install --url=http://localhost:8000 --title="Prova" --admin_user=host --admin_password=mi_contraseña --admin_email=mi@email.com

# Activem el plugin d'importacio
#docker exec -u www-data -i wordpress wp plugin ../all-in-one-wp-migration.6.77.zip --activate
docker exec -u www-data -i wordpress wp plugin install /var/www/html/wp-content/plugins/all-in-one-wp-migration.6.77.zip --activate

# Fem una copia de seguretat per crear el directori on es guarden les carpetes
docker exec -u www-data -i wordpress wp ai1wm backup

# Passem la el backup a la carpeta per poder-lo restaurar i l'script sql per executar despres
docker cp ./backup/divi.on-menu.com-20210913-072503-soo68c.wpress wordpress:/var/www/html/wp-content/ai1wm-backups/
docker cp ./sql/mail_admin.sql mysql:/var/tmp/


# wp ai1wm restore 
docker exec -u www-data -i wordpress wp ai1wm restore ./divi.on-menu.com-20210913-072503-soo68c.wpress

# Modifiquem el correu en la BBDD
# S'ha de revisar perque no funciona
# docker exec -i mysql sh -c 'exec mysql -uwpdock -pwpdock12345' < "/var/tmp/mail_admin.sql"

docker exec -u www-data -i wordpress wp post delete 1 692 689 678 676 657 614 546 547 30 699 698 697 696 695 694 684 683 673 672 667 666 665 663 662 661 660 637 636 635 634 633 632 629 631 630 628 627 626 625 624 623 622 621 620 619 618 617 595 592 591 588 587 585 584 583 582 577 560 56 34 --force

docker exec -u www-data -i wordpress wp menu delete Principal

docker exec -u www-data -i wordpress wp plugin delete hello advanced-custom-fields akismet asesor-cookies-para-la-ley-en-espana classic-editor wp-mail-bank themely inactive wp-whatsapp-chat

docker exec -u www-data -i wordpress wp plugin update wp-fastest-cache

# docker exec -u www-data -i wordpress wp rewrite structure '/%postname%/'

docker exec -u www-data -i wordpress wp plugin install woocommerce woocommerce-gateway-stripe woocommerce-pdf-invoices-packing-slips wc-apg-nifcifnie-field google-site-kit complianz-gdpr duplicate-page loco-translate wp-mail-smtp wpforms-lite wordpress-seo wp-whatsapp-chat wp-menu-icons code-snippets wordfence --activate

docker exec -u www-data -i wordpress wp ai1wm backup --replace "http://localhost:8000/" "https://dev.on-menu.com/"