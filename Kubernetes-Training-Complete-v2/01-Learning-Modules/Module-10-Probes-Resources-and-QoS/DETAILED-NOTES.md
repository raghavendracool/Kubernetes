# Detailed Notes — Probes, Resources and QoS

## Three Probe Questions

```text
startupProbe:  Has the application finished starting?
readinessProbe:Should this Pod receive traffic now?
livenessProbe: Is this container unhealthy enough to restart?
```

Do not use liveness as a dependency check that will restart every Pod when an external database is briefly unavailable. That can turn a dependency incident into a full application restart storm.

## Requests and Limits

The scheduler uses requests to decide whether a node has enough allocatable capacity. CPU limit throttles CPU; memory limit can lead to OOM termination if exceeded.

Example:

```yaml
resources:
  requests:
    cpu: 200m
    memory: 256Mi
  limits:
    cpu: 1
    memory: 512Mi
```

`200m` CPU means 0.2 CPU core.

## QoS

Kubernetes derives QoS class from requests/limits. Under node pressure, QoS contributes to eviction behavior. Do not treat it as a substitute for correct capacity planning.
