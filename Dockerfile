# Dockerfile

FROM php:8.1-apache

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copier la configuration Apache
COPY greenshop.conf /etc/apache2/sites-available/greenshop.conf
RUN a2dissite 000-default.conf && a2ensite greenshop.conf && a2enmod rewrite

# Copier les fichiers de l'application
COPY greenshop/ /var/www/html/

# Assurer les permissions correctes
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Copier le fichier SQL (s'il est présent dans ton dépôt)
COPY greenshop/database_dump.sql /var/www/html/database_dump.sql

# Modifier le fichier SQL pour désactiver le sandbox mode
RUN if [ -f /var/www/html/database_dump.sql ]; then \
    sed -i '/^\/\*M!999999\\- enable the sandbox mode \*\//d' /var/www/html/database_dump.sql; \
    fi

# Exposer le port 80
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]

