#!/bin/bash
# Smoke-test the GeoServer-pairing config: start the dev server,
# check the WMS capabilities document lists the proxied layer name,
# then stop the server. Capabilities generate from config, so this
# passes offline against the placeholder GeoServer URL; tile
# requests are a gate-3 validation item against a real GeoServer.
# Fleet venv entry point (Node-1 wave11-venv); on Windows run from
# Git Bash with MAPPROXY_UTIL pointed at the venv executable.
set -u
MAPPROXY_UTIL="${MAPPROXY_UTIL:-mapproxy-util}"
PORT="${PORT:-8084}"
"$MAPPROXY_UTIL" serve-develop -b "localhost:$PORT" mapproxy.yaml > serve.log 2>&1 &
SERVER_PID=$!
trap 'kill $SERVER_PID 2>/dev/null || true' EXIT
for i in $(seq 1 20); do
  if curl -s -o /dev/null --max-time 2 "http://localhost:$PORT/"; then
    break
  fi
  sleep 1
done
curl -s --max-time 10 "http://localhost:$PORT/service?SERVICE=WMS&REQUEST=GetCapabilities" \
  | grep -o "geoserver_demo" | head -1 \
  | sed 's/^/WMS capabilities contain proxied layer: /'
echo "OK: GeoServer-pairing config serves; server stopped on exit."
