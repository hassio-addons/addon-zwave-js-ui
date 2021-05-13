#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Z-Wave JS to MQTT
# Creates store folder if it doesn't exists yet
# ==============================================================================
declare gateway
declare host="core-mosquitto"
declare mqtt
declare password=""
declare port="1883"
declare username=""
declare zwave

if ! bashio::fs.directory_exists "/data/db"; then
  mkdir -p /data/db
fi

if bashio::fs.directory_exists "/data/store"; then
  bashio::exit.ok
fi

mkdir /data/store || bashio::exit.nok "Could not create data store."

gateway=$(bashio::var.json \
  "payloadType" "^0" \
  "type" "^0" \
  hassDiscovery "^false" \
  logEnabled "^true" \
  logLevel info \
  logToFile "^false" \
  nodeNames "^true" \
)

if bashio::services.available "mqtt"; then
  host=$(bashio::services "mqtt" "host")
  password=$(bashio::services "mqtt" "password")
  port=$(bashio::services "mqtt" "port")
  username=$(bashio::services "mqtt" "username")
fi

mqtt=$(bashio::var.json \
  auth "^true" \
  disabled "^true" \
  host "${host}" \
  name "Mosquitto" \
  password "${password}" \
  port "^${port}" \
  username "${username}" \
)

zwave=$(bashio::var.json \
  commandsTimeout "^30" \
  logLevel info \
  logToFile "^false" \
  networkKey "" \
  port "" \
  serverEnabled "^true" \
  serverPort "^3000" \
)

bashio::var.json \
  gateway "^${gateway}" \
  mqtt "^${mqtt}" \
  zwave "^${zwave}" \
  > /data/store/settings.json
