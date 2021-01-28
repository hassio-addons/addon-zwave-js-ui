#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Z-Wave JS to MQTT
# Creates store folder if it doesn't exists yet
# ==============================================================================
if ! bashio::fs.directory_exists "/data/store"; then
  mkdir /data/store
fi
