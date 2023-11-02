FROM caddy:2.7.5-builder AS builder

RUN xcaddy build \
    --with github.com/hairyhenderson/caddy-teapot-module@v0.0.3-0

FROM caddy:2.7.5-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
EXPOSE 80