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

A **MapProxy cookbook** — cached and merged WMS/WMTS services. Queued in wave-11 (per-node adds). Patterns are planned from the design, not yet from fleet runs. It is intended for Platform engineers who cache, reproject, and merge map services. Validate each pattern against your own data, software versions, and operating environment before adopting it.

## Repository role and status

**Status:** Active, public — seeding. Pattern passes land in follow-up work from fleet-verified setups; the tables below list what is planned, not what is already written.

**What this repository is:** MapProxy patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Platform engineers who cache, reproject, and merge map services.

## Prerequisites

- MapProxy in the fleet Python environment
- Python 3.11+
- A WMS source to proxy

## Patterns (planned)

| # | Example | What it will demonstrate |
|---|---------|--------------------------|
| 01 | `01-first-config` | A first MapProxy configuration: sources, caches, and layers |
| 02 | `02-wms-wmts` | Serving WMS and WMTS from one configuration |
| 03 | `03-seeding` | Seeding caches for an area and zoom range |
| 04 | `04-geoserver-pairing` | Proxying GeoServer layers through MapProxy (see geoserver-cookbook) |

## Repository layout

```text
mapproxy-cookbook/
├── examples/          # pattern passes, landing in follow-up work
├── README.md
└── LICENSE
```

## Roadmap

- First pattern pass: the first two table rows
- Second pass: the remaining rows, from fleet-verified setups

## Contributing

A contributing guide lands with the first pattern pass. Report security issues to <zqmcomputing@gmail.com> — please do not open a public issue for those.

## More from this series

- [geoserver-cookbook](https://github.com/ZQM-Computing/geoserver-cookbook) — Publishing, styling, federation, and securing OGC services
- [martin-cookbook](https://github.com/ZQM-Computing/martin-cookbook) — Vector tiles from PostGIS, function sources, tile serving
- [mapserver-cookbook](https://github.com/ZQM-Computing/mapserver-cookbook) — Fast OGC services from mapfiles, via MS4W
