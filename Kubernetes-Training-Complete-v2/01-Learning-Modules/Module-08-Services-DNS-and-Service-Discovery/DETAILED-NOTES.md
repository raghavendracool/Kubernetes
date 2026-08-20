# Detailed Notes — Services, DNS and Service Discovery

## Why Pod IP Is Not a Stable Application Endpoint

Pods are recreated during scaling, rollout and recovery, so their IPs change. A Service gives consumers a stable DNS name and virtual IP while the actual backend set changes.

## Service Types

- `ClusterIP`: cluster-internal stable endpoint; default.
- `NodePort`: opens a high port on nodes and forwards to the Service.
- `LoadBalancer`: asks supported infrastructure/controller integration for an external load balancer.
- `ExternalName`: DNS CNAME-style mapping to an external name.

## port vs targetPort

```text
Client -> Service port 80 -> Pod targetPort 5000
```

If the app listens on 5000 but targetPort says 8080, the Service object can look correct while traffic fails.

## EndpointSlices

EndpointSlices represent actual backend endpoints selected for a Service. When debugging a Service, check them early:

```bash
kubectl get endpointslices -l kubernetes.io/service-name=<svc> -o yaml
```

No endpoints usually means selector/readiness issues, not DNS.

## DNS

Within the cluster, a Service commonly resolves as:

```text
service-name.namespace.svc.cluster.local
```

Short names work according to the caller Pod's DNS search domains.
