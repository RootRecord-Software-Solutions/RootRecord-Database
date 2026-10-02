# Website analytics (Report Instructor)

**Source of truth:** Mainland Two API (first-party server logs + radio samples).

| Read | URL / path |
| --- | --- |
| Today | `https://api.rootrecord.cloud/api/analytics/daily` |
| Day | `https://api.rootrecord.cloud/api/analytics/daily?date=YYYY-MM-DD` |
| Period | `https://api.rootrecord.cloud/api/analytics/period?from=YYYY-MM-DD&to=YYYY-MM-DD` |
| Schema / honesty notes | ML2 desk `docs/ANALYTICS.md` |

`daily/` holds mirrored JSON pulled from the API for offline report runs. Also: `analytics-last.json` (same bytes as newest pull) and Database `Website/analytics/daily-last.json`.

**Pull:** `./pull-from-api.sh [YYYY-MM-DD]` or Pacific `Website/scripts/analytics_pull.py` (job `analytics_pull`, gate `RR_ANALYTICS_PULL=1`). Voice `bandwidth_desk` / `current_report` refresh when the day file is older than ~15 minutes.

**Home pageviews:** www is Vercel-only — not counted as full pageviews here. See `home.note` in the JSON and `api.home_proxy` for telemetry.js Referer signal only.

**Radio listens:** sampled from `radio.rootrecord.cloud` (ML1) into the same daily doc (`radio.*`).
