# Communications / Inbox

Local files written by `Communications/Inbox/scripts/inbox.py` from the quiet-mode relay hold.

| File | Role |
| --- | --- |
| `subscribers.json` | Local-only subscribe/unsubscribe **state flags**. Do not store Telegram user ids, usernames, or chat ids in git. |
| `feedback.jsonl` | Local-only notes. **Do not copy held Telegram message text, media, or PII.** Metadata keys only if needed (`update_id` / `message_id`). |
| `drain-ledger.jsonl` | Keys already copied (`update_id` or opaque message key — not chat/user PII). |
| `overnight-last.txt` | Late-night operator status text (not inbound Telegram bodies). A solar line is included only when one was passed in. |
| `reply-feedback.jsonl` | Operator notes appended with `feedback --note`. Old training JSONL is not imported. |

Telegram message text, captions, and media are git-ignored and must not be committed. This README is tracked.

Cloudflare D1 drain is not this folder. D1 sync has no Folder, so that half stays paused.
