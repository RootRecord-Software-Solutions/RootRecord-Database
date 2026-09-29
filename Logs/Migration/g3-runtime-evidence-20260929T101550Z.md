# G3 Runtime Evidence Snapshot — 2026-09-29T10:15:50Z (2026-09-29 00:15:50 HST)

Read-only capture from the Pacific desk against Library `Documentation/00-architecture/G3-Runtime-Verification-Runbook-2026-09-28.md`. No restarts, no runtime/config/credential changes, no hardware actions. Secrets, IPs and key paths redacted.

## Scores

| Row | State | Evidence (one line) |
| --- | --- | --- |
| Security/Cameras — cam server | PASS | `:8791` listener `python3 cam_server.py`, cwd Pacific `Security/Cameras`; `/health` HTTP 200 `{"ok": true}`; no cam process under `.ollama/skills` |
| Security/Cameras — frame grab | PASS | `security_camera_frame_grab` wrote ch1–ch4 JPEGs to `2 - RootRecord-Database/Media/Images/` at ~00:12 HST; Pacific tree clean; `store/` (CONNECTION.json) git-ignored |
| Security/Cameras — timelapse | VERIFY PENDING | hourly/catchup ran from Pacific but only skipped (outside 05–19 window / no frames); no compile/render observed |
| Telegram council relay | FAIL | 0 `council-relay.py` processes; relay log = 74× `No data: poll token`; `TELEGRAM_AVA_TOKEN` absent (SECRETS_1 file missing, SECRETS_2 has no Telegram key); `ensure-relay.sh` still logs `[ok] started` |
| Energy actions | VERIFY PENDING | Pacific `Energy/scripts/actions/*` present/executable; no `solar-gate-status` run in log (not executed — read-only capture) |
| Energy BLE owner (read side) | FAIL (legacy runtime) | `ava-ecoflow-ble.service` runs G2 `~/.ollama/skills/energy/scripts/ble/ble-owner.py`; Pacific `Energy/config/devices.conf` `owner_script` points there; no Pacific ble-owner.py |
| System sampling | PASS | `sys_stats_cycle` RUN Pacific `System/scripts/sys-sample.sh` → `OK wrote /home/rootrecord/Database/SYSTEM/samples/…json` every ~5 s |
| Reports worklog | PASS | `worklog_scan` RUN Pacific `Reports/scripts/worklog_once.sh` → `OK wrote/updated /home/rootrecord/Database/WORKLOG/worklog_current.md` |
| Plumbing non-NPU | VERIFY PENDING | `ollama_warmup` from Pacific `System/scripts/plumbing/` → `[ok] ollama up`; :11434 HTTP 200; no inference through Pacific single-flight — state dir `/home/rootrecord/Database/GITHUB/plumbing/state` does not exist |
| Plumbing NPU (FLM) | BLOCKED | no `flm` binary under $HOME, no `~/.local/opt/fastflowlm`, no `ava-flm.service`; :52625 unreachable; job logs `[skip] FLM binary not found` |
| Network globe | FAIL | `network-globe-hawaii.service` ExecStart/WorkingDirectory = G2 `~/.ollama/skills/coms/ssh/local-data-globe/collector.js` (running); Pacific has no collector |
| systemd ExecStart (poller) | PASS | `rr-rootserver-poller.service` (user) ExecStart `/bin/bash "<Pacific>/Automations/scripts/poller/run-poller.sh"`; MainPID = Pacific `rootserver_poller.py`, which imports `jobs` from its own dir |
| Pacific poller §5 | FAIL | poller + log path Pacific, log fresh, 0 `.ollama/skills` refs in last 3000 lines, no FAIL storm — but active Network Globe resolves to legacy runtime and Telegram relay not running |
| Precondition: single poller | PASS | exactly one `rootserver_poller.py` (Pacific); no G2 poller process |
| Precondition: single relay | PASS (no duplicate) | 0 relay processes — no second getUpdates owner (relay itself FAILs above) |
| Precondition: single cloudflared | PASS | 1 `cloudflared` process, Pacific `Communications/network/cloudflare/bin/cloudflared`, child of poller |

## Raw evidence (sanitized)

```text
captured_utc=2026-09-29T10:15:50Z captured_hst="2026-09-29 00:15:50 HST"
--- poller processes
pid=651134 ppid=2816 start="Mon Sep 28 23:40:20 2026"
  cmd: /usr/bin/python3 /home/rootrecord/RootRecord-Ecosystem/1 - Servers/1 - RootRecord-Pacific-Solar-Server/Automations/scripts/rootserver_poller.py 
  cwd: /home/rootrecord/RootRecord-Ecosystem/1 - Servers/1 - RootRecord-Pacific-Solar-Server
--- processes with cwd/cmdline under .ollama/skills
