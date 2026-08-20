# Networking Troubleshooting

```text
Pod status
 ↓
Pod IP
 ↓
DNS
 ↓
Service
 ↓
EndpointSlice
 ↓
NetworkPolicy
 ↓
Ingress / Load Balancer
 ↓
Application response
```

Commands:

```bash
kubectl get pods -o wide
kubectl get svc
kubectl get endpointslices
kubectl get networkpolicy
kubectl get ingress
```
