#!/bin/bash
# Serve WMS and WMTS from one configuration and check both
# capabilities documents. No persistent service is left running.
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
echo "--- WMS GetCapabilities ---"
curl -s --max-time 10 "http://localhost:$PORT/service?SERVICE=WMS&REQUEST=GetCapabilities" \
  | grep -o "demo_layer" | head -1 \
  | sed 's/^/WMS capabilities contain layer: /'
echo "--- WMTS GetCapabilities ---"
curl -s --max-time 10 "http://localhost:$PORT/service?SERVICE=WMTS&REQUEST=GetCapabilities" \
  | grep -o "demo_layer" | head -1 \
  | sed 's/^/WMTS capabilities contain layer: /'
echo "OK: WMS + WMTS capabilities served from one config; server stopped on exit."
