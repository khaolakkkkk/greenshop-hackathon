# il faut utiliser l'image d'Apache + PHP
FROM php:8.2-apache

# Copier les fichiers de la VM dans le conteneur
COPY ./greenshop/ /var/www/html/

# Activation du module rewrite d'Apache
RUN a2enmod rewrite

# Configuration des permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Exposer le port 80
EXPOSE 80

# Démarrer Apache
CMD ["apache2-foreground"]
