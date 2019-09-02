FROM        golang:1.12.9-alpine as builder
WORKDIR     /usr/src/zookeeper-exporter
COPY        main.go /usr/src/zookeeper-exporter
RUN         go build -v 

FROM        alpine:3.10.2
COPY        --from=builder /usr/src/zookeeper-exporter/zookeeper-exporter /usr/local/bin/zookeeper-exporter
ENTRYPOINT  ["/usr/local/bin/zookeeper-exporter"]
