FROM golang:1.24-alpine

RUN apk add --no-cache ca-certificates tzdata git \
    && adduser -D -h /home/container container

WORKDIR /home/container

# Quelle klonen & Dateien nach /home/container legen
RUN git clone https://github.com/2KU77B0N3S/hll-geofences.git repo && \
    cd repo && \
    go mod download && \
    go build -mod=mod -o /home/container/hll-geofences ./cmd/cmd.go && \
    chmod +x /home/container/hll-geofences && \
    cp config.example.yml /home/container/config.yml && \
    cp seeding.*.yml /home/container/ && \
    cd .. && rm -rf repo

# Entrypoint direkt nach /home/container legen
COPY entrypoint.sh /home/container/entrypoint.sh
RUN chmod +x /home/container/entrypoint.sh

# Benutzer setzen
USER container
ENV USER=container HOME=/home/container
CMD ["./entrypoint.sh"]
