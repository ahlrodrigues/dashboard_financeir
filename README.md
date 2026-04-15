# Dashboard Financeiro - Contratos Cancelados com Comodato Ativo

Dashboard para acompanhamento de contratos cancelados que ainda possuem equipamentos em comodato.

## Instalação

```bash
sudo bash install.sh
```

## Estrutura

```
dashboard_financeiro/
├── dashboard_financeiro.html  # Interface do dashboard
├── install.sh                 # Script de instalação
├── uninstall.sh               # Script de desinstalação
└── server.py                 # Servidor proxy API (copiado para /var/www/)
```

## Uso

1. Acesse: `http://localhost/` (ou IP do servidor)
2. Selecione o mês desejado
3. Clique em "Atualizar" para recarregar os dados

## Atualização Automática

O dashboard possui dois tipos de atualização:

1. **Navegador (JavaScript)**: A cada 5 minutos via `setInterval` - usa localStorage para cache
2. **Servidor (Cron)**: Script executado via cron para manter o servidor ativo

## Comandos

```bash
# Status do serviço
sudo systemctl status dashboard-financeiro

# Ver logs
sudo tail -f /var/log/dashboard_update.log

# Reiniciar serviço
sudo systemctl restart dashboard-financeiro

# Desinstalar
sudo bash uninstall.sh
```

## Configuração

O arquivo `server.py` contém as configurações da API:

```python
SGP_BASE = 'https://sgp.net4you.com.br/api'
AUTH = ('robo', 'Ox(?YMae?0V3V#}HIGcF')
```

Para alterar, edite `/var/www/dashboard_financeiro/server.py` e reinicie o serviço.

## Requisitos

- Debian/Ubuntu
- Python 3.8+
- Nginx
- Acesso à internet (para API do SGP)
