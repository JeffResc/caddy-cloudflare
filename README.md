# caddy-cloudflare

The official Caddy image with the
[caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare) module built
in, for ACME DNS-01 against Cloudflare.

## Why this exists

argus (the NixOS host in the homelab repo) runs Caddy as a podman container.
The stock image does not have a DNS provider module. Building Caddy with the
module through nixpkgs (`caddy.withPlugins`) broke on nixpkgs updates and
needed a manual hash bump for each Caddy release.

## What this image is

The two-stage build that the official image documents: `caddy:<version>-builder`
runs `xcaddy build --with github.com/caddy-dns/cloudflare`, and the result
replaces `/usr/bin/caddy` in `caddy:<version>`. Nothing else changes.

## Releasing

1. Set both `FROM` tags in the `Dockerfile` to the same Caddy version. Bump
   `CLOUDFLARE_VERSION` if a new module release exists.
2. Push a tag that matches the Caddy version, for example `v2.11.9`.
3. The release workflow pushes `ghcr.io/jeffresc/caddy-cloudflare:2.11.9` and
   `:latest` (linux/amd64 only).

A module-only bump goes out with the next Caddy release.
