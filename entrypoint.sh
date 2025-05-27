#!/bin/ash
cd /home/container

# config.yml nur kopieren, wenn sie nicht existiert
if [ ! -f config.yml ]; then
    echo "📁 Kopiere Standard config.yml..."
    cp /opt/defaults/config.yml .
fi

# seeding.midcap.yml nur kopieren, wenn sie nicht existiert
if [ ! -f seeding.midcap.yml ]; then
    echo "📁 Kopiere Standard seeding.midcap.yml..."
    cp /opt/defaults/seeding.midcap.yml .
fi

# seeding.lastcap.yml nur kopieren, wenn sie nicht existiert
if [ ! -f seeding.lastcap.yml ]; then
    echo "📁 Kopiere Standard seeding.lastcap.yml..."
    cp /opt/defaults/seeding.lastcap.yml .
fi

# Binary kopieren, falls sie fehlt
if [ ! -f ./hll-geofences ]; then
    echo "📁 Kopiere Binary hll-geofences..."
    cp /opt/defaults/hll-geofences ./hll-geofences
    chmod +x ./hll-geofences
fi

# Konfiguration anpassen, aber nur wenn beschreibbar
if [ -w /home/container ]; then
    echo "🔧 Konfiguration wird angepasst..."
    sed -i "s/1.1.1.1/${HLL_SERVER_IP}/g" seeding.midcap.yml
    sed -i "s/123456/${RCON_PORT}/g" seeding.midcap.yml
    sed -i "s/abcdef/${RCON_PASSWORD}/g" seeding.midcap.yml
    sed -i "s/50/${MIDCAP_LIMIT}/g" seeding.midcap.yml

    sed -i "s/1.1.1.1/${HLL_SERVER_IP}/g" seeding.lastcap.yml
    sed -i "s/123456/${RCON_PORT}/g" seeding.lastcap.yml
    sed -i "s/abcdef/${RCON_PASSWORD}/g" seeding.lastcap.yml
    sed -i "s/70/${LASTCAP_LIMIT}/g" seeding.lastcap.yml
fi

# .env-Datei schreiben
echo "HLL_SERVER_IP=${HLL_SERVER_IP}" > .env
echo "RCON_PORT=${RCON_PORT}" >> .env
echo "RCON_PASSWORD=${RCON_PASSWORD}" >> .env
echo "MIDCAP_LIMIT=${MIDCAP_LIMIT}" >> .env
echo "LASTCAP_LIMIT=${LASTCAP_LIMIT}" >> .env
# .env-Datei Ausgeben
echo "📄 Inhalt von .env:"
cat .env

# Prüfung auf notwendige Umgebungsvariablen
if [ -z "$HLL_SERVER_IP" ] || [ -z "$RCON_PORT" ] || [ -z "$RCON_PASSWORD" ]; then
    echo "❌ Fehler: Eine oder mehrere benötigte Umgebungsvariablen fehlen!"
    echo "Bitte stelle sicher, dass folgende Variablen gesetzt sind:"
    echo "  - HLL_SERVER_IP"
    echo "  - RCON_PORT"
    echo "  - RCON_PASSWORD"
    exit 1
fi

# Starte Anwendung
MODIFIED_STARTUP=$(eval echo "$STARTUP")
echo ":/home/container$ $MODIFIED_STARTUP"

echo "🚀 Starte hll-geofences..."
exec $MODIFIED_STARTUP
