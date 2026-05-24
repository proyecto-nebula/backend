#!/bin/bash
set -e

# Deshabilitar todos los MPMs para evitar conflictos en Railway
a2dismod mpm_event  2>/dev/null || true
a2dismod mpm_worker 2>/dev/null || true
a2dismod mpm_prefork 2>/dev/null || true

# Habilitar únicamente mpm_prefork (compatible con mod_php)
a2enmod mpm_prefork

# Arrancar Apache en primer plano
exec apache2-foreground
