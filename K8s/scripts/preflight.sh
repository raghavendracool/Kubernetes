#!/usr/bin/env bash
set -u
echo "=== Kubernetes Course Preflight ==="
for cmd in git docker kubectl minikube aws eksctl helm terraform; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[OK] $cmd"
  else
    echo "[INFO] $cmd not installed / not on PATH"
  fi
done
