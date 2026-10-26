#!/bin/bash
# List the seed tasks without fetching tiles: --summary prints the
# task list, --dry-run prints the tiles that would be seeded.
# A real seed run (no --dry-run) needs a live source and is a
# gate-3 validation item, not part of this pattern's runnable check.
# Requires mapproxy.yaml from pattern 01 (copy it here first).
# Fleet venv entry point (Node-1 wave11-venv); on Windows run from
# Git Bash with MAPPROXY_SEED pointed at the venv executable, e.g.:
#   MAPPROXY_SEED=C:/geo-tools/wave11-venv/Scripts/mapproxy-seed.exe bash run.sh
set -u
MAPPROXY_SEED="${MAPPROXY_SEED:-mapproxy-seed}"
echo "--- seed summary ---"
"$MAPPROXY_SEED" -f mapproxy.yaml -s seed.yaml --summary
echo "--- dry run (first 10 lines) ---"
"$MAPPROXY_SEED" -f mapproxy.yaml -s seed.yaml --dry-run 2>&1 | head -10
echo "OK: seed tasks listed without fetching tiles."
