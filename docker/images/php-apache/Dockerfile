#
# Base image
#
FROM talentify/phalcon-framework:3.3-php-7.1-apache-stretch AS base
LABEL version="1.0.0"
LABEL description="Image for Flux application."

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
#
# Add the ability to run commands as other user
ENV FLUX_USER=flux FLUX_GROUP=flux FLUX_USER_ID=1000 FLUX_USER_GID=1000
ENV APACHE_RUN_USER=flux APACHE_RUN_GROUP=flux
# Install gosu. Source: https://github.com/tianon/gosu/blob/master/INSTALL.md
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
	# verify that the binary works
	gosu nobody true
COPY flux-entrypoint /usr/local/bin
COPY flux-run /usr/local/bin
ENTRYPOINT ["flux-entrypoint"]
# Somehow CMD is undefined when I set ENTRYPOINT, so I set CMD again (as base image does).
CMD ["apache2-foreground"]
WORKDIR /var/www/


#
# Image for development
#
FROM base AS development
# Configure PHP
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" &&\
    pecl config-set php_ini "$PHP_INI_DIR/php.ini"
# Install xdebug and append our configuration within .ini file
# that usually contains only the instruction to load the extension.
COPY xdebug.ini /tmp
RUN pecl install xdebug-2.6.0 \
        && docker-php-ext-enable xdebug \
        && cat /tmp/xdebug.ini | grep -v '^#' >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
        && rm /tmp/xdebug.ini
# Add composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN flux-run composer global require hirak/prestissimo


#
# Image for Continuous Integration (CI)
#
FROM base AS ci
RUN apt-get update \
    && apt-get install --assume-yes gnupg \
    && curl -sL https://deb.nodesource.com/setup_9.x | bash -
# git is needed for AWS cli in order to do the deployment process
RUN apt-get install ruby-dev rubygems \
    git \
    nodejs \
    python-dev python-pip\
    ssh sshpass \
    zip --assume-yes \
    && gem update --system \
    && gem install sass --no-user-install \
    && npm install -g grunt-cli \
    && pip install awsebcli --upgrade \
    && curl -sOL https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz \
    && rm dockerize-linux-amd64-v0.6.1.tar.gz
