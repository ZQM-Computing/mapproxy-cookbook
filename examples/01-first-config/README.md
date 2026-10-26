# 01 — First config

A first MapProxy configuration: one WMS source, one cache, one layer.
Start the development server on localhost:8084 (the fleet smoke port),
check the demo page and the WMS capabilities document, then stop the
server. No persistent service is left running — the fleet smoke run
was stopped the same way, with the port verified free twice afterwards.

## Prerequisites

- MapProxy 7.0.0 (Node-1 wave11-venv, `C:/geo-tools/wave11-venv`)
- Python 3.12.10; curl for the smoke checks
- Bash for `run.sh` (Git Bash on Windows)

## Run

```bash
MAPPROXY_UTIL=C:/geo-tools/wave11-venv/Scripts/mapproxy-util.exe bash run.sh
```

## Expected output

- `demo page HTTP 200`.
- `capabilities contain layer: demo_layer`.
- `OK: demo page + WMS capabilities served; server stopped on exit.`

## Config notes

- The source URL (`http://localhost:9999/wms?`) is a placeholder:
  nothing listens there. MapProxy generates capabilities documents
  from config without contacting the source, so the smoke checks
  pass offline; a tile request against the placeholder source would
  fail, which is expected and is not a config error.
- `serve-develop` is a development server. Production serving uses a
  WSGI server; switching to one is a deployment decision, not part
  of this pattern.

## Failure behavior

- Port 8084 already bound: the server fails to start — stop the
  other listener or set `PORT` to a free port before re-running.
- Capabilities without `demo_layer`: the config did not load as
  written; check `serve.log` for YAML errors before assuming a
  MapProxy defect.

## Versions and evidence

- MapProxy 7.0.0 (Node-1 wave11-venv, wave-11 Part A, 2026-10-25;
  base-config create + serve-develop on 8084 smoke-proven there,
  `MP 200 138`, server then stopped).
- Draft-time execution (VM, same MapProxy 7.0.0 — not a fleet run):
  demo page + capabilities checks pass as above.

## Validation boundary

Design-only, gate 1 target. Fleet validation runs this script on
Node-1's wave11-venv and confirms the same outputs.
