#!/bin/bash

# ===========================================
# Script de Desinstalação - Dashboard Financeiro
# ===========================================

set -e

PROJECT_DIR="/var/www/dashboard_financeiro"
SERVICE_NAME="dashboard-financeiro"

echo "============================================"
echo "  Desinstalação - Dashboard Financeiro"
echo "============================================"

if [ "$EUID" -ne 0 ]; then
    echo "Execute este script como root (sudo)"
    exit 1
fi

echo "Parando serviços..."
systemctl stop ${SERVICE_NAME}.service 2>/dev/null || true
systemctl disable ${SERVICE_NAME}.service 2>/dev/null || true

echo "Removendo arquivos..."
rm -rf "$PROJECT_DIR"
rm -f "/etc/systemd/system/${SERVICE_NAME}.service"
rm -f "/etc/nginx/sites-available/${SERVICE_NAME}"
rm -f "/etc/nginx/sites-enabled/${SERVICE_NAME}"
rm -f "/var/log/dashboard_update.log"

echo "Recarregando serviços..."
systemctl daemon-reload
systemctl reload nginx

# Remover do cron
crontab -l 2>/dev/null | grep -v "update_cache.sh" | crontab - 2>/dev/null || true
sed -i '/update_cache.sh/d' /etc/crontab 2>/dev/null || true

echo ""
echo "============================================"
echo "  Desinstalação concluída!"
echo "============================================"
