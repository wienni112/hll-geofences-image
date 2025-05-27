FROM golang:1.24-alpine

# Abhängigkeiten & Benutzer
RUN apk add --no-cache ca-certificates tzdata git \
    && adduser -D -h /home/container container

# Arbeitsverzeichnis für Laufzeit
WORKDIR /home/container

# Quellcode bauen & Konfigs in /opt/app bereitstellen
RUN git clone https://github.com/2KU77B0N3S/hll-geofences.git repo && \
    cd repo && \
    go mod download && \
    go build -mod=mod -o /home/container/hll-geofences ./cmd/cmd.go && \
    mkdir -p /opt/app && \
    cp config.example.yml /opt/app/config.example.yml && \
    cp seeding.*.yml /opt/app/ && \
    cd .. && rm -rf repo

# Entrypoint-Script hinzufügen
COPY entrypoint.sh /opt/scripts/entrypoint.sh
RUN chmod +x /opt/scripts/entrypoint.sh

# Umgebungsvariablen und Benutzer
USER container
ENV USER=container HOME=/home/container

# Startbefehl
CMD ["/opt/scripts/entrypoint.sh"]
