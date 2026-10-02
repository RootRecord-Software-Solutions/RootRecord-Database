#!/bin/bash
# Mirror today's analytics JSON from ml2-api onto the desk bank path.
set -eu
DIR="$(cd "$(dirname "$0")" && pwd)"
DAY="${1:-$(TZ=Pacific/Honolulu date +%Y-%m-%d)}"
mkdir -p "$DIR/daily"
URL="https://api.rootrecord.cloud/api/analytics/daily?date=${DAY}"
tmp="$(mktemp)"
if curl -fsS --max-time 20 "$URL" -o "$tmp"; then
  mv -f "$tmp" "$DIR/daily/${DAY}.json"
  cp -f "$DIR/daily/${DAY}.json" "$DIR/analytics-last.json"
  mkdir -p "$DIR/../../../Website/analytics"
  # When DIR is .../Logs/Website/analytics, ../../.. is Database root? Logs/Website/analytics -> .. Website logs parent = Logs, ../.. = Database? 
  # DIR/../.. = Logs/Website -> Logs; DIR/../../.. = Database. Website/analytics is sibling of Logs under Database.
  DB_ROOT="$(cd "$DIR/../../.." && pwd)"
  mkdir -p "$DB_ROOT/Website/analytics"
  cp -f "$DIR/daily/${DAY}.json" "$DB_ROOT/Website/analytics/daily-last.json"
  echo "pulled $DAY -> $DIR/daily/${DAY}.json"
else
  rm -f "$tmp"
  echo "pull failed for $DAY" >&2
  exit 1
fi
