# Detailed Notes — Services, DNS and Service Discovery

## Why Pod IP Is Not a Stable Application Endpoint

Pods are recreated during scaling, rollout and recovery, so their IPs change. A Service gives consumers a stable DNS name and virtual IP while the actual backend set changes.

## Service Types

- `ClusterIP`: cluster-internal stable endpoint; default.
- `NodePort`: opens a high port on nodes and forwards to the Service.
- `LoadBalancer`: asks supported infrastructure/controller integration for an external load balancer.
- `ExternalName`: DNS CNAME-style mapping to an external name.

### Service Type Selection Cheat Logic

```text
Need access only from inside cluster?
	-> ClusterIP

Need simple external access in lab/on-prem without ingress/LB integration?
	-> NodePort

Need managed external entry point in cloud?
	-> LoadBalancer

Need to point workloads to an external DNS name only?
	-> ExternalName
```

### `kind` vs Service `spec.type`

Students often mix these up:

- `kind: Service` identifies which Kubernetes object is being created.
- `spec.type: ClusterIP|NodePort|LoadBalancer|ExternalName` configures how this Service is exposed.

Example:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: api
spec:
  type: NodePort
  selector:
    app: api
  ports:
    - port: 80
      targetPort: 5000
      nodePort: 30080
```

### Service YAML Anatomy (Component by Component)

Use this structure while teaching any Service manifest:

| YAML component | What it means | Example |
|---|---|---|
| `apiVersion` | API group/version for schema validation | `v1` |
| `kind` | Object category | `Service` |
| `metadata.name` | Service object name | `api` |
| `metadata.namespace` | Scope of this object | `training` |
| `spec.type` | Exposure behavior | `ClusterIP`, `NodePort`, `LoadBalancer`, `ExternalName` |
| `spec.selector` | Label query to choose backend Pods | `app: api` |
| `spec.ports[].port` | Port clients call on Service virtual IP/name | `80` |
| `spec.ports[].targetPort` | Container port on selected Pods | `5000` |
| `spec.ports[].nodePort` | Node-level port (NodePort only) | `30080` |
| `status` | Observed state from Kubernetes controllers | LB ingress details, assigned cluster IP |

Teaching note:

- Students usually write `apiVersion`, `kind`, `metadata`, and `spec`.
- Kubernetes controllers populate `status` after object creation.

## port vs targetPort

```text
Client -> Service port 80 -> Pod targetPort 5000
```

If the app listens on 5000 but targetPort says 8080, the Service object can look correct while traffic fails.

Tip for teaching:

- `port` = Service virtual port clients use.
- `targetPort` = container port on selected Pods.
- `nodePort` (NodePort only) = fixed port opened on each node.

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
