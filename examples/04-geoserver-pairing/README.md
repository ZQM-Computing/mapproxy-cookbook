# 04 — GeoServer pairing

Proxy GeoServer WMS layers through MapProxy: the GeoServer becomes
a MapProxy source, MapProxy caches and re-serves its layers. The
config here uses a placeholder GeoServer host and a placeholder
layer name — replace both with a GeoServer you control for a live
run. No credentials appear in the config: it proxies public layers
only.

## Prerequisites

- MapProxy 7.0.0 (Node-1 wave11-venv, `C:/geo-tools/wave11-venv`)
- geoserver-cookbook for the GeoServer side
- Bash for `run.sh` (Git Bash on Windows)

## Run

```bash
MAPPROXY_UTIL=C:/geo-tools/wave11-venv/Scripts/mapproxy-util.exe bash run.sh
```

## Expected output

- `WMS capabilities contain proxied layer: geoserver_demo`.
- `OK: GeoServer-pairing config serves; server stopped on exit.`

## Pairing notes

- Fleet shape evidence (not a live proxy assertion): Node-1's
  GeoServer WMS GetCapabilities was 230,380 bytes after the WPS
  install (wave-11 Part A, 2026-10-25) — that is the shape of the
  document MapProxy would re-serve, not a claim this pattern
  proxied it.
- Layer naming: the `layers:` value in the source request uses
  GeoServer's `workspace:layer` form; the MapProxy layer name
  (`geoserver_demo`) is independent and is what clients see.
- Authenticated GeoServer layers need credentials in the source
  request or a secured proxy setup — that is a deployment decision
  for the operator, never a value baked into a pattern.

## Failure behavior

- Capabilities without `geoserver_demo`: the config did not load
  as written; check `serve.log` for YAML errors.
- Tile requests failing against a real GeoServer: check the source
  URL, the workspace:layer spelling, and that the layer is
  published — capabilities listing the name proves config load,
  not source reachability.

## Versions and evidence

- MapProxy 7.0.0 (Node-1 wave11-venv, wave-11 Part A, 2026-10-25).
- Draft-time execution (VM, same MapProxy 7.0.0 — not a fleet run):
  capabilities check passes as above against the placeholder URL.

## Validation boundary

Design-only, gate 1 target. Fleet validation runs this script on
Node-1's wave11-venv, then points the source at a GeoServer the
validator controls and records a live tile round-trip.
