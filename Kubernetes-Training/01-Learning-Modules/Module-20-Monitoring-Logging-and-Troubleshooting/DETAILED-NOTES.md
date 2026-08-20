# Detailed Notes — Monitoring, Logging and Troubleshooting

## Troubleshooting Order

```text
1. Scope: cluster / namespace / app / one Pod?
2. State: kubectl get
3. Reasons/events: kubectl describe + get events
4. Application output: kubectl logs / --previous
5. Resources: kubectl top, requests/limits, node pressure
6. Connectivity: Pod IP -> Service -> DNS -> policy -> ingress
7. Host/system: kubelet, containerd, CNI, storage driver
```

## Common Status Patterns

- `Pending`: scheduler/storage/resource constraint.
- `ImagePullBackOff`: image/registry authentication or name.
- `CrashLoopBackOff`: process starts and repeatedly exits/fails.
- `OOMKilled`: memory usage crossed enforced boundary.
- `Running` but not Ready: readiness probe is failing.

## Monitoring Layers

- application metrics and SLOs;
- Pod/container metrics;
- node saturation/pressure;
- cluster component/add-on health;
- logs and audit/control-plane events;
- cloud load balancer/storage/network signals in managed platforms.

A dashboard is not the goal; actionable signals and alerts are.
