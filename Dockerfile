FROM golang:1.24-alpine

# Pakete installieren und Nutzer anlegen
RUN apk add --no-cache ca-certificates tzdata git \
    && adduser -D -h /home/container container

# Arbeitsverzeichnis setzen
WORKDIR /opt/app

RUN git clone https://github.com/2KU77B0N3S/hll-geofences.git repo && \
    cd repo && \
    go mod download && \
    go build -mod=mod -o /opt/app/hll-geofences ./cmd/cmd.go && \
    chmod +x /opt/app/hll-geofences && \
    cp config.example.yml /opt/app/config.yml && \
    cp seeding.*.yml /opt/app/ && \
    cd .. && rm -rf repo

# Entrypoint außerhalb von /home/container platzieren
COPY entrypoint.sh /opt/app/entrypoint.sh
RUN chmod +x /opt/app/entrypoint.sh

# Auf container-Nutzer umschalten
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
# CMD oder ENTRYPOINT robust setzen
CMD ["/bin/ash", "/entrypoint.sh"]
