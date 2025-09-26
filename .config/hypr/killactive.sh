#!/usr/bin/env bash

set -euo pipefail
json="$(hyprctl activewindow -j 2>/dev/null || true)"
title="$(jq -r '.title // empty' <<<"$json")"
class="$(jq -r '.class // empty' <<<"$json")"

if [[ -z "$title$title$class" ]]; then
  exit 0
fi

whitelist=("Overwatch")

is_whitelisted=false
for pat in "${whitelist[@]}"; do
  if [[ "$title" == *"$pat"* || "$class" == *"$pat"* ]]; then
    is_whitelisted=true
    break
  fi
done

if $is_whitelisted; then
    notify-send "Refusing to close window"
else
    hyprctl dispatch killactive
fi
