FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    git \
    unzip \
    curl \
    zip \
    libzip-dev \
    icu-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    oniguruma-dev \
    nodejs \
    npm \
    sqlite \
    sqlite-dev \
    nano \
    && rm -rf /var/lib/apt/lists/* 

# Configure and install PHP extensions
RUN docker-php-ext-configure zip && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install \
        zip \
        pdo \
        pdo_mysql \
        pdo_sqlite \
        exif \
        gd \
        intl \
        mbstring \
        pcntl \
        bcmath \
        xml

# Install Composer using the official image
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Set working directory
WORKDIR /var/www

# Copy your application code (this is only used at build time)
# In development, you may prefer to mount your code as a volume.
# COPY . /var/www
# COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Install Composer dependencies and Node packages (optional during build)
# You may comment these out if you prefer running them interactively.
# RUN composer install && npm install

# Make the entrypoint script executable - alternative to running composer install. handled by entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh

# Set development PHP.ini settings
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Expose ports for PHP-FPM and Vite
# EXPOSE 9000 5173
EXPOSE 9000 3000


# Add a non-root user for development
# RUN addgroup -g 1000 developer && \
#     adduser -u 1000 -G developer -s /bin/sh -D developer && \
#     chown -R developer:developer /var/www && \
#     chmod -R 755 /var/www

# # # Switch to non-root user
# USER developer

# Default command (you may override this in docker-compose)
CMD ["php-fpm"]
# ENTRYPOINT ["entrypoint.sh"]
