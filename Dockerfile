# Dockerfile for Simple Calculator
FROM php:7.4-apache

# Set working directory
WORKDIR /var/www/html

# Copy source code
COPY . .

# Expose port 80 for the web server
EXPOSE 80