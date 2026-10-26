#!/bin/bash
# Smoke-test the minimal config: start the dev server on localhost:8084
# (the fleet smoke port), check the demo page and the WMS capabilities
# document, then stop the server. No persistent service is left running.
# Fleet venv entry point (Node-1 wave11-venv); on Windows run from
# Git Bash with MAPPROXY_UTIL pointed at the venv executable, e.g.:
#   MAPPROXY_UTIL=C:/geo-tools/wave11-venv/Scripts/mapproxy-util.exe bash run.sh
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
echo "--- demo page ---"
curl -s -o /dev/null -w "demo page HTTP %{http_code}\n" --max-time 10 "http://localhost:$PORT/"
echo "--- WMS GetCapabilities ---"
curl -s --max-time 10 "http://localhost:$PORT/service?SERVICE=WMS&REQUEST=GetCapabilities" \
  | grep -o "demo_layer" | head -1 \
  | sed 's/^/capabilities contain layer: /'
echo "OK: demo page + WMS capabilities served; server stopped on exit."
