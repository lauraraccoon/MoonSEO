#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.moon/bin:$PATH"

moon build cmd/web --target js
python3 ./scripts/dev_server.py
