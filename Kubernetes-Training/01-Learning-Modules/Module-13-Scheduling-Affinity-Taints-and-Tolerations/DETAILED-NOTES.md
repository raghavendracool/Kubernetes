# Detailed Notes — Scheduling

## Scheduler Logic

The scheduler first filters nodes that cannot run a Pod, then scores suitable nodes. Reasons for filtering include insufficient requested CPU/memory, untolerated taints, required affinity, volume topology and other constraints.

## Attraction and Repulsion

```text
nodeSelector / node affinity -> place Pods on matching nodes
pod affinity                 -> place near matching Pods
a nti-affinity                -> separate from matching Pods
taint                         -> repel Pods
toleration                    -> allow Pod onto matching taint
```

A toleration does not force placement; it only removes one rejection reason.

## Availability

For replicas that should survive node/AZ failure, use anti-affinity or topology spread carefully so all replicas do not land on one failure domain.

## First Pending Check

`kubectl describe pod` often includes scheduler messages like `0/3 nodes are available: insufficient cpu` or untolerated taint. Read that evidence before changing random settings.
