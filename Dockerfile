FROM golang:1.24-alpine

RUN apk add --no-cache ca-certificates tzdata git \
    && adduser -D -h /home/container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

RUN git clone https://github.com/2KU77B0N3S/hll-geofences.git repo && \
    cd repo && go mod download && \
    go build -mod=mod -o /home/container/hll-geofences ./cmd/cmd.go && \
    chmod +x /home/container/hll-geofences && \
    cp config.example.yml /home/container/config.yml && \
    cd .. && rm -rf repo

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]
