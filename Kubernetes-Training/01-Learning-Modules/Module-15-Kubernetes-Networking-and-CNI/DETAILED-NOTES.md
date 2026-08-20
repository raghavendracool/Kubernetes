# Detailed Notes — Kubernetes Networking and CNI

## Network Model

Each Pod receives an IP. Pods should be able to communicate according to cluster network policy without applications knowing which physical node hosts the peer.

## CNI

CNI plugins create/configure Pod network interfaces, IP allocation and routing/overlay behavior. Examples include Calico and cloud-provider networking implementations.

## Service Routing

Service IPs are virtual. kube-proxy or another dataplane programs rules that send Service traffic toward actual endpoints.

## Troubleshooting Layers

```text
1. Is Pod running and listening?
2. Can caller reach Pod IP?
3. Does Service have EndpointSlices?
4. Can caller reach Service IP/name?
5. Does DNS resolve?
6. Does NetworkPolicy allow flow?
7. Does node/CNI routing work cross-node?
```

Testing each layer prevents mixing an app-port issue with a CNI issue.
