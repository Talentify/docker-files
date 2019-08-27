FROM talentify/flux:base
LABEL description="Image for development on Flux application."

# Install git in order to allow composer to clone talentify/ repositories.
RUN set -eux; \
	apt-get update; \
	apt-get install -y \
	git \
	unzip \
	&& rm -rf /var/lib/apt/lists/*

# Configure PHP
COPY ./talentify.ini /tmp
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" &&\
    pecl config-set php_ini "$PHP_INI_DIR/php.ini" &&\
    mv /tmp/talentify.ini "$PHP_INI_DIR/conf.d"
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
