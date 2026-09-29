# Logs / Automations

Live automation / poller log stream for the Pacific solar node.

## Current file

| File | Role |
|------|------|
| `automations_current.log` | Active poller + job output (tailed by `poller-watch.py`) |
| `stack_reload_current.log` | Stack reload script output (created on first reload) |
| `Archive/` | Daily / weekly / monthly rotation (see Archive/README) |

## Desk absolute path

```text
/home/rootrecord/Database/Logs/Automations/automations_current.log
```

This directory is the **desk checkout** of `RootRecord-Software-Solutions/RootRecord-Database` (or a bind that matches this tree).

## Writers / readers (Pacific)

| Component | Uses |
|-----------|------|
| `rr-rootserver-poller.service` / poller stdout | Should append here (or via `POLLER_LOG`) |
| `Automations/scripts/poller/poller-watch.py` | Default `POLLER_LOG` → this file |
| `open-poller-window.sh` / `run-poller.sh` | Same default |
| `stack/do-stack-reload.sh` | `stack_reload_current.log` |

Env overrides: `POLLER_LOG`, `STACK_RELOAD_LOG`.

## Archive policy

See [Archive/README.md](Archive/README.md): daily move of `*_current.log` → `Archive/<LOGTYPE>_<DATE>.log`, weekly zip, monthly zip.

## Note on git size

`automations_current.log` is operational data. Prefer rotation into Archive and avoid unbounded growth in the tracked current file. Optional: gitignore `*_current.log` later if sync policy changes.
