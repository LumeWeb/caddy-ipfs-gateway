ARG CADDY_VERSION=2.10.0
ARG GO_VERSION=1.26

FROM golang:${GO_VERSION} AS builder

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with go.lumeweb.com/caddy-plugin-cert-webhook

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /go/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
