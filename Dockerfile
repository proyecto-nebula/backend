FROM php:8.2-apache-bullseye
ARG APP_ENV=production
ENV APP_ENV=${APP_ENV}

# Habilitar módulos Apache
RUN a2enmod rewrite headers

# Cambiar el DocumentRoot a /var/www/html/public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf

# Instalar extensiones necesarias
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Instalar unzip (requerido por Composer para extraer paquetes)
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html


RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/' /usr/local/etc/php/php.ini \
    && docker-php-ext-enable opcache \
    && printf '[opcache]\nopcache.enable=1\nopcache.memory_consumption=128\nopcache.max_accelerated_files=4000\nopcache.revalidate_freq=60\n' > /usr/local/etc/php/conf.d/opcache.ini \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && printf '[apcu]\napc.enable=1\napc.enable_cli=1\napc.shm_size=64M\n' > /usr/local/etc/php/conf.d/apcu.ini

# Instalar dependencias PHP (capa separada para aprovechar la caché de Docker)
COPY composer.json composer.lock* ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts
# Copiar el resto del código fuente del proyecto al contenedor
COPY . .

# Ajustar los permisos para que Apache pueda acceder y servir los archivos
RUN chown -R www-data:www-data /var/www/html

# Entrypoint personalizado: garantiza que solo mpm_prefork esté activo en Railway
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
CMD ["/usr/local/bin/docker-entrypoint.sh"]