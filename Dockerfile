# Official Caddy image with the Cloudflare DNS provider module built in, for
# ACME DNS-01. This is the build the official image documents for adding
# modules: xcaddy in the matching -builder image, then the binary copied over
# the stock one. Keep both FROM tags on the same Caddy version.
FROM docker.io/library/caddy:2.11.9-builder AS builder
ARG CLOUDFLARE_VERSION=v0.2.4
RUN xcaddy build --with github.com/caddy-dns/cloudflare@${CLOUDFLARE_VERSION}

FROM docker.io/library/caddy:2.11.9
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
