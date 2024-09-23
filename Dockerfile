# Use an official PHP image
FROM php:7.4-apache

# Install MySQL extensions
RUN docker-php-ext-install pdo pdo_mysql

# Copy application code
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html/

# Expose port 80
EXPOSE 80
