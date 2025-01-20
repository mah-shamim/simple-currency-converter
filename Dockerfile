# Use PHP 7.4 Apache base image
FROM php:7.4-apache

# Install MySQL PDO and other PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory in container
WORKDIR /var/www/html

# Copy project files into the container
COPY . .

# Set permissions (optional, based on your project needs)
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port
EXPOSE 80

#CMD ["apache2-foreground"]
