# MapProxy Cookbook

<!-- ZQM-START -->
<!-- markdownlint-disable MD033 -->
<p align="center">
  <strong>ZQM Computing — Geospatial Engineering & Scientific Computing</strong><br>
  <a href="https://github.com/ZQM-Computing">ZQM Computing</a>
</p>
<!-- markdownlint-enable MD033 -->
<!-- ZQM-END -->

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A **MapProxy cookbook** — cached and merged WMS/WMTS services. Patterns are drawn from the ZQM fleet's wave-11 installs (MapProxy 7.0.0 on Node-1, serve-proven on 8084) and are design-only until fleet-validated. It is intended for Platform engineers who cache, reproject, and merge map services. Validate each pattern against your own data, software versions, and operating environment before adopting it.

## Repository role and status

**Status:** Active, public. First pattern pass written (design-only, gate 1 target — none runtime-validated on the fleet yet).

**What this repository is:** MapProxy patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Platform engineers who cache, reproject, and merge map services.

## Prerequisites

- MapProxy in the fleet Python environment
- Python 3.11+
- A WMS source to proxy

## Patterns

| # | Example | What it demonstrates | Status |
|---|---------|----------------------|--------|
| 01 | [examples/01-first-config](examples/01-first-config) | A first MapProxy configuration: sources, caches, and layers | Written (design-only) |
| 02 | [examples/02-wms-wmts](examples/02-wms-wmts) | Serving WMS and WMTS from one configuration | Written (design-only) |
| 03 | [examples/03-seeding](examples/03-seeding) | Seeding caches for an area and zoom range | Written (design-only) |
| 04 | [examples/04-geoserver-pairing](examples/04-geoserver-pairing) | Proxying GeoServer layers through MapProxy (see geoserver-cookbook) | Written (design-only) |

## Repository layout

```text
mapproxy-cookbook/
├── examples/
│   ├── 01-first-config/
│   ├── 02-wms-wmts/
│   ├── 03-seeding/
│   └── 04-geoserver-pairing/
├── README.md
└── LICENSE
```

## Roadmap

- First pattern pass: all four table rows (this pass, design-only)
- Next pass: gate-3 fleet validation on Node-1's wave11-venv

## Contributing

A contributing guide lands with the first pattern pass. Report security issues to <zqmcomputing@gmail.com> — please do not open a public issue for those.

## More from this series

- [geoserver-cookbook](https://github.com/ZQM-Computing/geoserver-cookbook) — Publishing, styling, federation, and securing OGC services
- [martin-cookbook](https://github.com/ZQM-Computing/martin-cookbook) — Vector tiles from PostGIS, function sources, tile serving
- [mapserver-cookbook](https://github.com/ZQM-Computing/mapserver-cookbook) — Fast OGC services from mapfiles, via MS4W
