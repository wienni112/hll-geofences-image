FROM golang:1.24-alpine

# Pakete installieren und Nutzer anlegen
RUN apk add --no-cache ca-certificates tzdata git \
    && adduser -D -h /home/container container

# Arbeitsverzeichnis setzen
WORKDIR /home/container

# Projekt aus dem Git-Repo klonen, bauen und Dateien kopieren
RUN git clone https://github.com/2KU77B0N3S/hll-geofences.git repo && \
    cd repo && \
    go mod download && \
    go build -mod=mod -o /home/container/hll-geofences ./cmd/cmd.go && \
    chmod +x /home/container/hll-geofences && \
    # nur kopieren, wenn Datei nicht existiert (default config)
    cp -n config.example.yml /home/container/config.yml || true && \
    cp -n seeding.*.yml /home/container/ || true && \
    cd .. && rm -rf repo

# Entrypoint außerhalb von /home/container platzieren
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Auf container-Nutzer umschalten
USER container
ENV USER=container HOME=/home/container

# CMD oder ENTRYPOINT robust setzen
CMD ["/bin/ash", "/entrypoint.sh"]
