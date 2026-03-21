#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.moon/bin:$PATH"

moon build cmd/web --target js
python3 -m http.server 4173
