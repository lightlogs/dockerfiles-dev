FROM php:7.4-fpm

ARG user
ARG uid

# Libraries needed to install PHP extensions.
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libgmp-dev \
    libpq-dev \
    zip \
    unzip

RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd zip gmp

RUN cd /usr/local/etc/php/conf.d/ && \
  echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

# Installing latest version of Composer.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installing Node, Npm & Npx.
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get update && apt-get install -y nodejs

# Creating new sure, to make sure not everything is written using 'root' user.
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

USER $user

# Using Composer package used for parallel downloads.
RUN composer global require hirak/prestissimo