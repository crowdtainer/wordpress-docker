FROM wordpress:php8.2-fpm-alpine
RUN set -ex && apk update && apk add --no-cache libxml2-dev php-soap && docker-php-ext-install soap && docker-php-ext-enable soap;
