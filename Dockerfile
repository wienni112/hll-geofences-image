FROM golang:1.24-alpine

RUN apk add --no-cache ca-certificates tzdata git \
    && adduser -D -h /home/container container

WORKDIR /opt/app

RUN git clone https://github.com/2KU77B0N3S/hll-geofences.git repo && \
    cd repo && go mod download && \
    go build -mod=mod -o /opt/app/hll-geofences ./cmd/cmd.go && \
    chmod +x /opt/app/hll-geofences && \
    cp config.example.yml /opt/app/config.yml && \
    cp -r sync vendor worker seeding.*.yml /opt/app/ && \
    cd .. && rm -rf repo

# Entrypoint-Script hinzufügen
COPY entrypoint.sh /opt/scripts/entrypoint.sh
RUN chmod +x /opt/scripts/entrypoint.sh

USER container
ENV USER=container HOME=/home/container
CMD ["/opt/scripts/entrypoint.sh"]
