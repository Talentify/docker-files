FROM talentify/phalcon-framework:3.3-php-7.1-apache-stretch
LABEL version="1.1.0"
LABEL description="Base image for Flux application."

# Install dependencies
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
        soap \
        && pecl install redis \
        yaml \
        mailparse \
        amqp \
        && docker-php-ext-enable redis \
        yaml \
        mailparse \
        amqp

# Configure Apache
RUN a2enmod rewrite ssl
COPY --chown=www-data sites-enable/* /etc/apache2/sites-enabled/
EXPOSE 443

# Add the ability to run commands as other user
ENV FLUX_USER=flux FLUX_GROUP=flux FLUX_USER_ID=1000 FLUX_USER_GID=1000
ENV APACHE_RUN_USER=flux APACHE_RUN_GROUP=flux
RUN groupadd -r $FLUX_GROUP --gid=$FLUX_USER_GID &&\
    useradd -r -g $FLUX_GROUP -G www-data --uid=$FLUX_USER_ID --create-home --shell=/bin/bash $FLUX_USER
# Install gosu. Source: https://github.com/tianon/gosu/blob/master/INSTALL.md
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
	# verify that the binary works
	gosu nobody true
COPY bin/* /usr/local/bin/
ENTRYPOINT ["flux-entrypoint"]
# Somehow CMD is undefined when I set ENTRYPOINT, so I set CMD again (as base image does).
CMD ["apache2-foreground"]

WORKDIR /var/www/
