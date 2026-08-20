#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace student-app --ignore-not-found
