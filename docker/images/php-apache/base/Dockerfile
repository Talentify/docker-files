FROM php:7.1-apache
LABEL version="0.3.0"
LABEL description="Image for Flux application."

ENV PHALCON_VERSION=3.3.2

RUN apt-get update && apt-get install -y \
        libcurl3 \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libyaml-dev \
        mysql-client \
        ssl-cert \
        libxml2-dev \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install zip \
        && docker-php-ext-install mbstring \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install soap \
        && pecl install redis \
        && pecl install yaml \
        && pecl install mailparse \
        && docker-php-ext-enable redis yaml mailparse

RUN cd /usr/src \
        && curl -sSL "https://codeload.github.com/phalcon/cphalcon/tar.gz/v${PHALCON_VERSION}" | tar -xz \
        && cd cphalcon-${PHALCON_VERSION}/build \
        && ./install \
        && cd ../../ \
        && rm -r cphalcon-${PHALCON_VERSION}

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin -- --filename=composer
RUN composer global require hirak/prestissimo

COPY php.ini /usr/local/etc/php/php.ini

RUN a2enmod rewrite ssl

COPY sites-enable/ssl.conf /etc/apache2/sites-enabled/ssl.conf

RUN chown www-data /etc/apache2/sites-enabled/ssl.conf

EXPOSE 443

WORKDIR /var/www/
