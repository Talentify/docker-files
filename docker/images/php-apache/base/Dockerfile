FROM php:7.1-apache
LABEL version="0.4.0"
LABEL description="Image for Flux application."

ENV PHALCON_VERSION=3.3.2

# RabbitMQ/amqp extension needs librabbitmq-dev and libssh-dev apt packages.
# Source: https://github.com/php-amqplib/php-amqplib/issues/521#issuecomment-357807290
RUN apt-get update && apt-get install -y \
        libcurl3 \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libyaml-dev \
        mysql-client \
        ssl-cert \
        libxml2-dev \
        librabbitmq-dev \
        libssh-dev \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install mysqli \
        pdo_mysql \
        zip \
        mbstring \
        soap \
        && pecl install redis \
        yaml \
        mailparse \
        amqp \
        && docker-php-ext-enable redis \
        yaml \
        mailparse \
        amqp

RUN cd /usr/src \
        && curl -sSL "https://codeload.github.com/phalcon/cphalcon/tar.gz/v${PHALCON_VERSION}" | tar -xz \
        && cd cphalcon-${PHALCON_VERSION}/build \
        && sed -i -e 's/-march=native -mtune=native/-march=core-avx-i -mtune=core-avx-i/g' install \
        && ./install \
        && cd ../../ \
        && rm -r cphalcon-${PHALCON_VERSION}

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin -- --filename=composer
RUN composer global require hirak/prestissimo

COPY php.ini /usr/local/etc/php/php.ini

RUN a2enmod rewrite ssl

COPY sites-enable/ssl.conf /etc/apache2/sites-enabled/ssl.conf

COPY sites-enable/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN chown www-data /etc/apache2/sites-enabled/ssl.conf

RUN chown www-data /etc/apache2/sites-enabled/000-default.conf

EXPOSE 443

WORKDIR /var/www/
