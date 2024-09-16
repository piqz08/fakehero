# Use PHP 7.4 FPM Alpine image
FROM php:7.4-fpm-alpine

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
    && docker-php-ext-install pdo pdo_mysql

RUN apk add --no-cache \
    icu-dev \
    freetds-dev \
    unixodbc-dev \
    libxml2-dev \
    curl \
    wget \
    build-base \
    --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/main/ \
    --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Install SQLSRV and PDO_SQLSRV extensions
RUN pecl install pdo_sqlsrv-5.10.0 sqlsrv-5.10.0 \
    && docker-php-ext-enable pdo_sqlsrv sqlsrv

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Set up working directory
WORKDIR /var/www/jtbdashboard

# Copy application files
COPY . .

# Configure Git
RUN git config --global --add safe.directory /var/www/jtbdashboard

# Command to run the application
CMD ["php-fpm"]
