# Utilise une image de base avec Apache + PHP
FROM php:8.1-apache

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copier le VirtualHost, désactiver le site par défaut, activer le nouveau site et mod_rewrite
COPY greenshop.conf /etc/apache2/sites-available/greenshop.conf
RUN a2dissite 000-default.conf \
    && a2ensite greenshop.conf \
    && a2enmod rewrite

# Copier le code du site et fixer les permissions
COPY greenshop/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

RUN sed -i '/^\/\*M!999999\\- enable the sandbox mode \*\//d' database_dump.sql

# Expose le port 80 (Apache)
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]
