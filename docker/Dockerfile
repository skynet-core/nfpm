ARG ALPINE_VERSION=3.12
ARG GO_VERSION=1.15.6

FROM golang:${GO_VERSION}-alpine${ALPINE_VERSION}

ARG NFPM_VERSION=1.10.2
ENV NFPM_VERSION=${NFPM_VERSION}

RUN echo "Packaging nfpm version: ${NFPM_VERSION}" && apk update && apk upgrade && apk add --no-cache git bash sudo && \
    cd /tmp && git clone https://github.com/goreleaser/nfpm && \
    cd ./nfpm && git checkout "v${NFPM_VERSION}" && \
    go mod download && cat cmd/nfpm/main.go | sed "s|version = \"master\"|version  = \"${NFPM_VERSION}\"|g" > /tmp/main.go && mv /tmp/main.go cmd/nfpm/main.go && \
    go build -o nfpm cmd/nfpm/main.go && \
    mv nfpm /usr/local/bin && rm -rf /tmp/*


COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && addgroup -g 1000 nfpm && adduser -h /home/nfpm -g "Nfpm User" \
    -s /bin/bash -D -u 1000 -G nfpm nfpm && \
    echo "%nfpm         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && chown -R nfpm:nfpm /home/nfpm

USER nfpm
WORKDIR /home/nfpm

ENTRYPOINT ["/entrypoint.sh"]