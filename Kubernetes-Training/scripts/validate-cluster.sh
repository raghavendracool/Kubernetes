#!/usr/bin/env bash
set -euo pipefail

echo '== Context =='
kubectl config current-context

echo '== Cluster Info =='
kubectl cluster-info

echo '== Nodes =='
kubectl get nodes -o wide

echo '== System Pods =='
kubectl get pods -n kube-system -o wide

echo '== Non-running Pods =='
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded || true

echo '== Recent Events =='
kubectl get events -A --sort-by=.lastTimestamp | tail -30
