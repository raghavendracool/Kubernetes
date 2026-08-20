# Detailed Notes — Workload Controllers

## Deployment
Use when replicas are interchangeable and identity does not matter.

## StatefulSet

Pods receive stable ordinal names such as `db-0`, `db-1`. With `volumeClaimTemplates`, each replica can receive its own PVC. StatefulSet does not make an application database-safe automatically; the application still needs correct replication/consistency design.

## DaemonSet

Ensures a matching Pod is present on selected nodes. Typical examples: log agents, monitoring agents, node networking components.

## Job

Runs Pods until a completion goal is met. Important fields include retry/backoff behavior and parallelism/completions.

## CronJob

Creates Jobs from a cron schedule. Think about concurrency policy, missed schedules, job history and timezone expectations.

Choose a controller by asking: **Is this workload long-running? stateful? node-local? finite? scheduled?**
