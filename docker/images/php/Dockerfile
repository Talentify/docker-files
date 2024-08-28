#|
#| Base CLI image
#|
# List of supported tags
# https://github.com/docker-library/docs/blob/master/php/README.md#supported-tags-and-respective-dockerfile-links
FROM php:8.3.10-fpm-bookworm AS cli-base

# Install gRPC first because it takes too long.
RUN apt-get update && apt-get install -y libzip-dev