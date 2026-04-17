#!/usr/bin/env bash
set -euo pipefail

SOURCE_JS="./_build/js/debug/build/cmd/web/web.js"
TARGET_JS="./web/app.js"

if [[ ! -f "$SOURCE_JS" ]]; then
  echo "Missing compiled web bundle: $SOURCE_JS" >&2
  echo "Run: moon build cmd/web --target js" >&2
  exit 1
fi

sed '$d' "$SOURCE_JS" > "$TARGET_JS"
