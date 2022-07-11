FROM php:7-apache

RUN apt-get update
# RUN apt-get install -y apache2




RUN docker-php-ext-install gettext
RUN docker-php-ext-install json
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-enable gettext
RUN docker-php-ext-enable json
RUN docker-php-ext-enable pdo
RUN docker-php-ext-enable pdo_mysql


#install some base extensions
RUN apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install zip


RUN apt-get -y update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl


RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd


RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN a2enmod rewrite
RUN a2enmod headers
RUN apache2ctl -k graceful