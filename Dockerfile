#!/bin/ash
cd /home/container

# Konfigurationsdateien bereitstellen (wenn noch nicht vorhanden)
if [ ! -f config.yml ]; then
    echo "📄 Kopiere Standard-Konfigurationsdateien..."
    cp /opt/app/seeding.midcap.yml ./seeding.midcap.yml
    cp /opt/app/seeding.lastcap.yml ./seeding.lastcap.yml
    cp /opt/app/config.example.yml ./config.yml
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

# Startup command von Pterodactyl (Umgebungsvariable)
MODIFIED_STARTUP=$(eval echo "$STARTUP")
echo ":/home/container$ $MODIFIED_STARTUP"

echo "🚀 Starte hll-geofences..."
exec $MODIFIED_STARTUP
