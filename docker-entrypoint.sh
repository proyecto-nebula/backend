#!/bin/bash
set -e

# Deshabilitar todos los MPMs para evitar conflictos en Railway
a2dismod mpm_event  2>/dev/null || true
a2dismod mpm_worker 2>/dev/null || true
a2dismod mpm_prefork 2>/dev/null || true

# Habilitar únicamente mpm_prefork (compatible con mod_php)
a2enmod mpm_prefork

# Arrancar Apache en primer plano
# Configurar OpCache/APCu para desarrollo si `APP_ENV` != production
if [ -n "${APP_ENV}" ] && [ "${APP_ENV}" != "production" ]; then
	echo "Configuring PHP opcache for development (validate_timestamps=1, revalidate_freq=0)"
	if [ -f /usr/local/etc/php/conf.d/opcache.ini ]; then
		sed -i 's/opcache.revalidate_freq=.*/opcache.revalidate_freq=0/' /usr/local/etc/php/conf.d/opcache.ini || true
		if grep -q '^opcache.validate_timestamps' /usr/local/etc/php/conf.d/opcache.ini 2>/dev/null; then
			sed -i 's/opcache.validate_timestamps=.*/opcache.validate_timestamps=1/' /usr/local/etc/php/conf.d/opcache.ini || true
		else
			printf '\nopcache.validate_timestamps=1\n' >> /usr/local/etc/php/conf.d/opcache.ini
		fi
	fi
fi

# Vaciar OpCache y APCu al arrancar (no falla si no existen)
php -r 'if(function_exists("opcache_reset")) { opcache_reset(); } if(function_exists("apcu_clear_cache")) { apcu_clear_cache(); }' || true

exec apache2-foreground
