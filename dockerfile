FROM php:8.2-apache

# Garantizar un único MPM (Railway puede activar mpm_event además del prefork de la imagen)
RUN a2dismod mpm_event mpm_worker 2>/dev/null || true \
    && a2enmod mpm_prefork rewrite

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

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/' /usr/local/etc/php/php.ini

# Instalar dependencias PHP (capa separada para aprovechar la caché de Docker)
COPY composer.json composer.lock* ./
RUN composer install --no-dev --optimize-autoloader --no-interaction