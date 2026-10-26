# 03 — Seeding

Pre-generate cache tiles for an area and zoom range with
`mapproxy-seed`. This pattern's runnable checks are `--summary`
and `--dry-run`, which list the seed tasks and tiles without
fetching anything — so they run offline against the placeholder
source from pattern 01. A real seed run fetches tiles from the
source and is a gate-3 validation item against a live source.

## Prerequisites

- MapProxy 7.0.0 (Node-1 wave11-venv, `C:/geo-tools/wave11-venv`)
- `mapproxy.yaml` from pattern 01 (copy it into this directory)
- Bash for `run.sh` (Git Bash on Windows)

## Run

```bash
cp ../01-first-config/mapproxy.yaml .
MAPPROXY_SEED=C:/geo-tools/wave11-venv/Scripts/mapproxy-seed.exe bash run.sh
```

## Expected output

- The summary lists the `demo_seed` task (cache `demo_cache`,
  levels 0–2, coverage `demo_coverage`, reported in EPSG:4326 as
  about -0.08983 to 0.08983 degrees).
- Seed output carries the demo-page-enabled warning (`Application
  has demo page enabled. It is recommended to disable this in
  production.`) — expected with the demo service on; disable demo
  for production configs.
- Dry-run tile-count accounting is a validation item: the draft
  run's progress lines need confirming against the fleet run before
  any tile count is asserted in this pattern.
- The dry run lists tiles that would be seeded (no tiles fetched,
  no cache written).
- `OK: seed tasks listed without fetching tiles.`

## Seeding notes

- Levels 0–2 over the 20 km synthetic coverage keep the tile count
  small by construction. Wider areas or deeper levels grow the
  count fast — estimate with `--dry-run` before any real seed run.
- A real seed run writes into the cache dir configured for
  `demo_cache`; point caches at scratch storage for test seeds,
  never at a production cache.
- `--continue` resumes an aborted seed from a progress file; a
  failed real seed run is resumed, not restarted from scratch,
  unless the coverage or levels changed.

## Failure behavior

- Summary/dry-run failing on config errors: the seed file or the
  proxy config did not parse — fix the YAML before assuming a
  MapProxy defect.
- A real seed run failing mid-task: tiles already written stay
  cached; re-run with `--continue` after fixing the source.

## Versions and evidence

- MapProxy 7.0.0 (Node-1 wave11-venv, wave-11 Part A, 2026-10-25).
- Draft-time execution (VM, same MapProxy 7.0.0 — not a fleet run):
  summary + dry-run list tasks as above; no tiles were fetched.

## Validation boundary

Design-only, gate 1 target. Fleet validation runs this script on
Node-1's wave11-venv, then runs a real seed against a live source
the validator controls and records tile counts.
