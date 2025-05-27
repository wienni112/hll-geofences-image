#!/bin/ash

# Set defaults if not defined
SERVER_IP="${SERVER_IP:-1.1.1.1}"
RCON_PORT="${RCON_PORT:-123456}"
RCON_PASSWORD="${RCON_PASSWORD:-abcdef}"
MIDCAP_LIMIT="${MIDCAP_LIMIT:-50}"
LASTCAP_LIMIT="${LASTCAP_LIMIT:-70}"

echo "🔧 Konfiguration wird angepasst..."
sed -i "s/1.1.1.1/${SERVER_IP}/g" /opt/app/seeding.midcap.yml
sed -i "s/123456/${RCON_PORT}/g" /opt/app/seeding.midcap.yml
sed -i "s/abcdef/${RCON_PASSWORD}/g" /opt/app/seeding.midcap.yml
sed -i "s/50/${MIDCAP_LIMIT}/g" /opt/app/seeding.midcap.yml

sed -i "s/1.1.1.1/${SERVER_IP}/g" /opt/app/seeding.lastcap.yml
sed -i "s/123456/${RCON_PORT}/g" /opt/app/seeding.lastcap.yml
sed -i "s/abcdef/${RCON_PASSWORD}/g" /opt/app/seeding.lastcap.yml
sed -i "s/70/${LASTCAP_LIMIT}/g" /opt/app/seeding.lastcap.yml

echo "🚀 Starte hll-geofences..."
exec /opt/app/hll-geofences
