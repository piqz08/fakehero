# Use PHP 7.4 FPM Alpine image
FROM php:7.4-fpm-alpine

# Update PHP-FPM to listen on port 9001
RUN sed -i 's/9000/9001/g' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/9000/9001/g' /usr/local/etc/php-fpm.d/zz-docker.conf

# Install necessary packages
RUN apk update && apk add --no-cache \
    git \
    bash \
    sudo \
    libxslt-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    gd \
    libzip-dev \
    unzip \
    gcc \
    g++ \
    make \
    autoconf \
    zlib-dev \
    freetype-dev \
    libtool \
    pkgconf \
    && docker-php-ext-install zip && docker-php-ext-install xsl gd \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install mysqli

RUN apk add nodejs npm

# Fix permissions for the Cypress cache directory
RUN mkdir -p /root/.cache/Cypress && chmod -R 777 /root/.cache/Cypress

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set up working directory
WORKDIR /var/www/e-form

# Copy application files
COPY . .

# Configure Git
RUN git config --global --add safe.directory /var/www/e-form

# Command to run the application
CMD ["php-fpm"]
