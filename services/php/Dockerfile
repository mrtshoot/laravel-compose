FROM php:7.4-fpm

# Use the default production configuration
# ----------------------------------------
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# oniguruma-dev \

# Install the necessary packages and php extensions
# ----------------------------------------
RUN apt-get update && apt-get install -y \
        cron \
        build-essential \
        libmcrypt-dev \
        zlib1g-dev \
        libonig-dev \
        graphviz \
        libjpeg-dev \
        #libjpeg62-turbo-dev \ 
        libpng-dev \
        libfreetype6-dev \
        zlib1g-dev \
        libxslt-dev \
        libzip-dev \
        libxml2-dev curl \
        supervisor \
        openssl \
        libssl-dev \
        libcurl4-openssl-dev \
        && docker-php-ext-install soap pcntl xml xsl exif mbstring zip pdo_mysql

# PHP GD 
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# INSTALL PHP-REDIS EXTENSION
RUN pecl install redis && docker-php-ext-enable redis

# INSTALL PHP-MONGODB EXTENSION
RUN pecl install mongodb && docker-php-ext-enable mongodb

# Install composer
# ----------------------------------------
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Horizon and Supervisor configuration
# ----------------------------------------
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY horizon.conf /etc/supervisor/conf.d/horizon.conf

ADD startup.sh /etc/startup.sh

RUN chmod +x /etc/startup.sh

ADD start-supervisor.sh /opt/start-supervisor.sh
RUN chmod +x /opt/start-supervisor.sh


# CRON-JOBS
# ----------------------------------------
RUN touch /var/log/cron.log
RUN chmod 750 /var/log/cron.log
COPY laravel-schedule /etc/cron.d/laravel-schedule

# Custom entry point to run supervisor 
# services and docker-php-fpm entry point
# ----------------------------------------
WORKDIR /var/www/website/
ENTRYPOINT ["/etc/startup.sh"]
