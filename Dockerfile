FROM wordpress:6.0-php7.4
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
COPY ./plugins/all-in-one-wp-migration.6.77.zip /var/www/html/wp-content/plugins
