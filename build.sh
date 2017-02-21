#!/bin/sh
set -ex
### start tkalus mod
apk add --update curl go git mercurial build-base ca-certificates
curl https://logdog.loggly.com/media/logs-01.loggly.com_sha12.crt \
    -o /usr/local/share/ca-certificates/logs-loggly.crt
update-ca-certificates
### end   tkalus mod
mkdir -p /go/src/github.com/gliderlabs
cp -r /src /go/src/github.com/gliderlabs/logspout
cd /go/src/github.com/gliderlabs/logspout
export GOPATH=/go
go get
go build -ldflags "-X main.Version=$1" -o /bin/logspout
apk del go git mercurial build-base
rm -rf /go
rm -rf /var/cache/apk/*

# backwards compatibility
ln -fs /tmp/docker.sock /var/run/docker.sock
