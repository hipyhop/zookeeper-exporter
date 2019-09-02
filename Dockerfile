FROM        golang:1.12.9-alpine as builder
RUN         mkdir /user && \
            echo 'nobody:x:65534:65534:nobody:/:' > /user/passwd && \
            echo 'nobody:x:65534:' > /user/group
WORKDIR     /usr/src/zookeeper-exporter
COPY        main.go /usr/src/zookeeper-exporter
RUN         CGO_ENABLED=0 go build -v

FROM        scratch
COPY        --from=builder /user/group /user/passwd /etc/
COPY        --from=builder /usr/src/zookeeper-exporter/zookeeper-exporter /zookeeper-exporter
USER        nobody:nobody
ENTRYPOINT  ["/zookeeper-exporter"]