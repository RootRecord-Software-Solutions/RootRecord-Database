# NPU / FastFlowLM verification — 2026-09-29 02:50–02:56 HST

State: **PASS**. The NPU inference gate was run once through the Pacific plumbing, with no service restart. Backup: `/home/rootrecord/Database/GITHUB/g3-npu-verify.bak-20260929-025336/`.

## Stack (Alexander installed `libxrt-utils`, `libxrt-utils-npu`, FastFlowLM 1.0.6)
- `xrt-smi examine`: RyzenAI-npu6 (aie2p, 6x8, FW 1.1.2.64). `flm validate`: `/dev/accel/accel0`, 8 columns, amdxdna 0.7, memlock infinity (operator-reported).
- `flm version`: v1.0.6 (`/usr/bin/flm`). Packages: libxrt2, libxrt-npu2, libxrt-utils, libxrt-utils-npu 2.25.0-4~resolute1; linux-firmware-amd-misc 20260319.
- G2 `~/.ollama/skills/plumbing/scripts/npu-status.sh` (read-only; there is no Pacific copy): accel0 present, the packages above installed, single-flight IDLE.

## Model
- `flm list`: none installed. Pulled **llama3.2:1b** once (4 files verified, 1.3 GB in `~/.config/flm/models/Llama-3.2-1B-NPU2`). Nothing else was pulled.

## Gate test (Pacific `System/scripts/plumbing/`)
1. `FLM_MODEL=llama3.2:1b flm-warmup.sh` → `flm serve llama3.2:1b --pmode default` on 127.0.0.1:52625 (test pid 57993), `/v1/models` OK.
2. `FLM_MODEL=llama3.2:1b run-infer.sh ava "Reply with one short sentence: what is 2+2?"` → holder `infer:ava:20260929-025241` → stderr `[ok] FLM/NPU llama3.2:1b`, rc 0. Reply: "I am RootRecord, and I am not attached to a desk." (The voice system prompt steered it; the content is not part of the gate.)
   - FLM log: `NPU Locked!` → prefill 132 tokens → `NPU Lock Released!`.
   - **End-to-end latency 1.04 s** (warm model, max_tokens 180, short reply). The FLM log does not report tokens/s at this level.
3. A parallel `single-flight.sh run parallel-test -- echo …` while the lock was held → `[busy] refuse parallel run`, **rc 75**. Same result as the non-NPU test.
4. Test server stopped afterwards (`kill 57993`), port closed, single-flight IDLE. FLM starts naturally via the `flm_npu_warmup` ON_BOOT job at the next poller start.

## Config findings (not changed; need Alexander)
- `jobs.py` `flm_npu_warmup` (priority 4, timeout 240 s) and `flm-warmup.sh`/`run-infer.sh` default to **llama3.2:3b**, which is **not downloaded**. At the next poller start `flm serve llama3.2:3b` will try to fetch it (multi-GB), and the warmup gives up after 20 s with `[warn] FLM not ready yet`.
- `--pmode default` is not in FLM 1.0.6's listed modes (powersaver/balanced/performance/turbo). The server accepted it for this test.
- **Behaviour change once FLM is up:** `council-relay.py` prefers FLM through `run-infer.sh`. The relay will then start **posting Telegram replies** from the FLM model (today replies are BLOCKED only because the Ollama `*-telegram` models are missing). Alexander should decide the model and whether replies go live.

## Fixed (in scope, no restart)
- FLM logs record full request bodies (system prompt and user text). The old default `2 - RootRecord-Database/GITHUB/logs/flm.log` was **not ignored** and was committed (Database d64b8fd).
  - `flm-warmup.sh` now defaults to git-ignored `Logs/AI/FLM/flm.log`.
  - Database `.gitignore` adds `/GITHUB/logs/` and `/Logs/AI/FLM/*` (`.gitkeep` kept).
  - The already-tracked `GITHUB/logs/flm.log` stays tracked until an approved `git rm --cached -- GITHUB/logs/flm.log`. It no longer changes.
