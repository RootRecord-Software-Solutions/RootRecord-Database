# RootRecord-Database

**Official source of truth for data and log layout** inside the RootRecord Pacific node (desk path: `/home/rootrecord/Database`).

Owned by org **[RootRecord-Software-Solutions](https://github.com/RootRecord-Software-Solutions)**.

Code and domain scripts live in server repos (especially [RootRecord-Pacific-Solar-Server](https://github.com/RootRecord-Software-Solutions/RootRecord-Pacific-Solar-Server)). **This repo owns where bytes go** — not application logic.

---

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

Each domain: current log(s) in the folder; dated files and zips under `Archive/` (see each `Archive/README.md` when present).

## Pacific poller wiring

Default live stream:

```text
/home/rootrecord/Database/Logs/Automations/automations_current.log
```

Set by Pacific `Automations/scripts/poller/*` and stack scripts (`POLLER_LOG` / `STACK_RELOAD_LOG` overrides).

---

## Related canonical repos

| Repository | Role |
| --- | --- |
| [RootRecord-Pacific-Solar-Server](https://github.com/RootRecord-Software-Solutions/RootRecord-Pacific-Solar-Server) | Primary desk runtime |
| [RootRecord-Library](https://github.com/RootRecord-Software-Solutions/RootRecord-Library) | Docs, agent context, work orders |
| [US-Mainland-Server](https://github.com/rootrecordsoftwaresolutions/US-Mainland-Server) | Continuity node |

Migration and domain-import status: Library → `Documentation/06-development/`.

---

**Docs-only updates** to this README do not change on-disk layout or poller behavior.
