# RootRecord-Database

Canonical **data and log layout** for the RootRecord Pacific node (desk path: `/home/rootrecord/Database`).

Code lives in domain server repos (e.g. `RootRecord-Pacific-Solar-Server`). This repo owns **where bytes go**.

## Top level

| Path | Role |
|------|------|
| `Logs/` | Domain-aligned log streams + Archive rotation |
| `Media/` | Audio / notifications / voice reports |
| *(existing desk dirs)* | `SYSTEM/`, `WORKLOG/`, `WEATHER/`, `GITHUB/`, Energy stores, etc. may live on disk even if not all mirrored here yet |

## Logs layout

```text
Logs/
  Automations/     automations_current.log  (+ Archive/)
  Energy/
  Communications/
  Network/
  System/
  Weather/
  Github/
  Security/
```

Each domain: current log(s) in the folder; dated files and zips under `Archive/` (see each `Archive/README.md`).

## Pacific poller wiring

Default live stream:

```text
/home/rootrecord/Database/Logs/Automations/automations_current.log
```

Set by Pacific `Automations/scripts/poller/*` and stack scripts (`POLLER_LOG` / `STACK_RELOAD_LOG` overrides).

## Related

- Server code: `RootRecord-Software-Solutions/RootRecord-Pacific-Solar-Server`
- Docs index: `RootRecord-Software-Solutions/RootRecord-Library`
