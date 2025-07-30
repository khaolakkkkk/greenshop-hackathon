FROM php:8.1-apache


RUN docker-php-ext-install mysqli pdo pdo_mysql


COPY greenshop.conf /etc/apache2/sites-available/greenshop.conf
RUN a2dissite 000-default.conf && a2ensite greenshop.conf && a2enmod rewrite


COPY greenshop/ /var/www/html/


RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html


COPY database_dump.sql /var/www/html/database_dump.sql


RUN if [ -f /var/www/html/database_dump.sql ]; then \
    sed -i '/^\/\*M!999999\\- enable the sandbox mode \*\//d' /var/www/html/database_dump.sql; \
fi


EXPOSE 80


CMD ["apache2-foreground"]


