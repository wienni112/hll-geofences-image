FROM golang:1.24-alpine

# Pakete installieren und Nutzer anlegen
RUN apk add --no-cache ca-certificates tzdata git \
    && adduser -D -h /home/container container

# Arbeitsverzeichnis setzen
WORKDIR /build

# Repo klonen und Binary + Default-Dateien in /opt/defaults ablegen
RUN git clone https://github.com/2KU77B0N3S/hll-geofences.git repo && \
    mkdir -p /opt/defaults && \
    cd repo && \
    go mod download && \
    go build -mod=mod -o /opt/defaults/hll-geofences ./cmd/cmd.go && \
    cp config.example.yml /opt/defaults/config.yml && \
    cp seeding.*.yml /opt/defaults/ && \
    cd .. && rm -rf repo

# Entrypoint außerhalb von /home/container platzieren
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Auf container-Nutzer umschalten
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
# CMD oder ENTRYPOINT robust setzen
CMD ["/bin/ash", "/entrypoint.sh"]
