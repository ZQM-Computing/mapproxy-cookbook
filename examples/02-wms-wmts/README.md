# 02 — WMS + WMTS

Serve WMS and WMTS from one configuration backed by the same cache.
Both capabilities documents list the same layer; the cache is shared,
so a tile seeded once serves both protocols.

## Prerequisites

- MapProxy 7.0.0 (Node-1 wave11-venv, `C:/geo-tools/wave11-venv`)
- Pattern 01's config concepts (sources, caches, layers, grids)
- Bash for `run.sh` (Git Bash on Windows)

## Run

```bash
MAPPROXY_UTIL=C:/geo-tools/wave11-venv/Scripts/mapproxy-util.exe bash run.sh
```

## Expected output

- `WMS capabilities contain layer: demo_layer`.
- `WMTS capabilities contain layer: demo_layer`.
- `OK: WMS + WMTS capabilities served from one config; server stopped on exit.`

## Config notes

- The `wmts:` service block with no options enables the default
  WMTS service (KVP endpoint at `/service`). RESTful WMTS URL
  shapes are a validation item — this pattern asserts the KVP
  capabilities document only.
- The source URL is a placeholder (see pattern 01): capabilities
  generate offline; tile requests against it would fail.

## Failure behavior

- WMTS capabilities missing the layer while WMS has it: the `wmts:`
  service block did not load — check `serve.log` for config errors.
- Port 8084 already bound: stop the other listener or set `PORT`.

## Versions and evidence

- MapProxy 7.0.0 (Node-1 wave11-venv, wave-11 Part A, 2026-10-25).
- Draft-time execution (VM, same MapProxy 7.0.0 — not a fleet run):
  both capabilities checks pass as above.

## Validation boundary

Design-only, gate 1 target. Fleet validation runs this script on
Node-1's wave11-venv and confirms both capabilities documents.
