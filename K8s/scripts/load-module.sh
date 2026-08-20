#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 1 ]]; then
  echo "Usage: bash scripts/load-module.sh <module-number>"
  exit 1
fi
num=$(printf "%02d" "$1")
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
module_dir=$(find "$root/learning-modules" -maxdepth 1 -type d -name "Module-${num}-*" | head -n1 || true)
if [[ -z "$module_dir" ]]; then
  echo "Module ${num} not found."
  exit 1
fi
stage="$module_dir/stage"
if [[ ! -d "$stage" ]]; then
  echo "Module ${num} has no stage. Use its examples directly."
  exit 0
fi
live="$root/kubernetes-live/manifests"
mkdir -p "$live"
find "$live" -mindepth 1 -maxdepth 1 -type f ! -name '.gitkeep' -delete
cp -a "$stage/." "$live/"
echo "Loaded $(basename "$module_dir")"
ls -1 "$live"
