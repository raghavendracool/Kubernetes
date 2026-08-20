#!/usr/bin/env bash
set -euo pipefail
echo "=== Context ==="
kubectl config current-context
echo "=== Nodes ==="
kubectl get nodes -o wide
echo "=== System Pods ==="
kubectl get pods -n kube-system -o wide
echo "=== API Readiness ==="
kubectl get --raw='/readyz?verbose' || true
echo "=== Recent Events ==="
kubectl get events -A --sort-by=.lastTimestamp | tail -n 30
