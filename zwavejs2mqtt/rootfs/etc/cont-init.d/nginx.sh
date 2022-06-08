#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Z-Wave JS to MQTT
# Configures NGINX for use with this add-on.
# ==============================================================================
bashio::var.json \
    entry "$(bashio::addon.ingress_entry)" \
    | tempio \
        -template /etc/nginx/templates/ingress.gtpl \
        -out /etc/nginx/servers/ingress.conf
