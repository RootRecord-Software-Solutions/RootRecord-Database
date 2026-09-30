# Logs / Communications / Relay-Inbox

Quiet-mode hold for the Pacific council relay (`Communications/telegram/scripts/council-relay.py`).
Approved by Alexander 2026-09-29 (Library `08-ideas/2026-09-29-relay-quiet-mode-message-hold.md`).

While `RR_RELAY_REPLIES=0` (the default), the relay still consumes each Telegram update (one getUpdates owner). **Do not persist Telegram message bodies, captions, or media payloads in this database tree.** If a hold record is written at all, store operational metadata only and omit PII.

| File | Role |
| --- | --- |
| `relay-inbox_current.jsonl` | Local-only. Optional metadata per held update: `ts`, `received_ts`, `update_id`, `message_id`, `persona_target`, `status`. **Never** `text`, `caption`, file/photo/voice/document payloads, `from` (id/username/name), or `chat_id`. |
| `Archive/YYYY-MM-DD/relay-inbox_YYYY-MM-DD_HH00.jsonl` | Hourly cut of the same metadata-only records |
| `replayed.jsonl` | Local-only ledger of already-handled `update_id`/`message_id` pairs (no message text) |

Files are created `0600` (folder `0700`). Silence cues and non-text updates are not held.

## Privacy

Telegram message content of any kind must not appear on the git surface of this repository. Everything here except this README is **git-ignored** (`*.log` plus `/Logs/Communications/Relay-Inbox/*` in `.gitignore`). Check with `git check-ignore -v Logs/Communications/Relay-Inbox/relay-inbox_current.jsonl`.

## Replay (answering held messages later)

Replay tooling lives in the Pacific runtime repo, not here. Default listing is metadata-only. Do not dump message text into Database logs, worklogs, or sample files.

It sends **only** with both `--send` and `RR_RELAY_REPLIES=1`; otherwise it refuses with exit 3. Enabling sends needs Alexander's sign-off.

*Created 2026-09-29 ~04:03 HST. Privacy: no Telegram bodies in tracked Database artifacts (2026-09-30).*
