# Previous dataset — G2 old Database root (archived 2026-09-29)

Moved (not copied, nothing deleted) at **2026-09-29 01:46 HST** from the old G2 data root `/home/rootrecord/Database/` into this archive, on Alexander's approval ("move all the old data into archives as previous datasets … in case there's importance or value later"). Same filesystem → `mv` rename; contents are byte-for-byte what was there.

Before the move: `lsof` showed no open files under `/home/rootrecord/Database/`, and the residual path survey (`Logs/Migration/g3-residual-path-survey-20260929T113523Z.md`) showed no running process or active Pacific default writing there (the live data had already moved to the canonical root `2 - RootRecord-Database/`).

**Git:** only this README is tracked. Everything else in this folder is git-ignored (`/Archive/Previous-Datasets/*/*`) — it contains binaries, media, sqlite and private worklog content. Total size ≈ **4.5 GB**.

**Not moved:** `/home/rootrecord/Database/GITHUB/` (backups, sync flags, worktrees — `BAK_ROOT`) and `/home/rootrecord/Database/README.md`.

| Folder | Size | Files | Oldest file (HST) | Newest file (HST) | Came from / what it is |
| --- | --- | --- | --- | --- | --- |
| `A-EYES/` | 302M | 1974 | 2026-09-27 15:34 | 2026-09-28 18:19 | G2 A-Eyes camera output (`_archive`, `final_output`, `frames`, `video_chunks`). Live stills now go to canonical `Media/Images/`. |
| `ENERGY/` | 12M | 2976 | 2026-09-27 09:15 | 2026-09-29 00:42 | Energy JSON samples/soc/watts/ports/buckets/state; stopped when Energy moved to canonical `ENERGY/` (~00:42). |
| `Energy/` | 8.0K | 0 | — | — | empty `state/` folder. |
| `Logs/` | 8.0M | 3 | 2026-09-29 00:57 | 2026-09-29 01:19 | `Automations/automations_current.log` (poller log, frozen 01:11 at poller realign), `Automations/stack_reload_current.log` (last write 01:19 reload), `Energy/ava-ecoflow-ble.log`. |
| `ROOTRECORD/` | 281M | 10 | 2026-09-27 18:37 | 2026-09-28 16:18 | Energy sqlite store `rootrecord.db` + `layers/*.db` (Energy/db/store.py). A **copy** is now the live store at canonical `ROOTRECORD/` (git-ignored); this is the original. |
| `SYSTEM/` | 55M | 4370 | 2026-09-27 09:05 | 2026-09-29 00:42 | System sampler output (cpu/load/mem/last/samples/status/layers, `system.db`); stopped when System moved to canonical `SYSTEM/`. |
| `WEATHER/` | 3.8G | 19290 | 2026-09-27 22:56 | 2026-09-28 16:19 | G2 weather daemon data (`Hawai'i/hfo`, `hurricanes`, `reports`, `logs`). The Pacific weather daemon (enabled 2026-09-29) now writes fresh data to canonical `WEATHER/Hawai'i/` (git-ignored). |
| `WORKLOG/` | 9.7M | 32 | 2026-09-27 09:46 | 2026-09-29 00:41 | Reports worklog segments (private, mode 700); live worklog is canonical `WORKLOG/`. |
| `intake/` | 8.0K | 0 | — | — | empty `council-relay/` state folder; relay state is canonical `intake/council-relay/`. |

Dormant G2 code under `~/.ollama/skills` (kept, not run) still names some of these old paths; if run it would recreate folders under `/home/rootrecord/Database/`.
