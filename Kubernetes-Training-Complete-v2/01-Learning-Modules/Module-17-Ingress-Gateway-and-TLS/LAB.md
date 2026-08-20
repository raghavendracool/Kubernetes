# Module 17 — Ingress, Gateway Concepts and TLS: Hands-On Lab

## Objective
Understand that an Ingress resource requires a controller.

```bash
kubectl get ingressclass
kubectl get pods -A | grep -Ei 'ingress|load-balancer|gateway' || true
```

Create backend resources:

```bash
kubectl create namespace ingress-lab
kubectl create deployment web --image=nginx:alpine -n ingress-lab
kubectl expose deployment web --port=80 --target-port=80 -n ingress-lab
```

Find the IngressClass:

```bash
kubectl get ingressclass
```

Create `ingress.yaml`, replacing `<INGRESS_CLASS>` with the class installed in your environment:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web
  namespace: ingress-lab
spec:
  ingressClassName: <INGRESS_CLASS>
  rules:
    - host: web.training.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web
                port:
                  number: 80
```

```bash
kubectl apply --dry-run=server -f ingress.yaml
kubectl apply -f ingress.yaml
```

Validate:

```bash
kubectl get ingress -A
kubectl describe ingress <name> -n <namespace>
kubectl get svc,endpointslice -n <namespace>
```

If the Ingress address remains empty, investigate controller installation, IngressClass, events and—in EKS—controller IAM/subnet/network dependencies.

For TLS practice:

```bash
kubectl create secret tls demo-tls --cert=tls.crt --key=tls.key -n <namespace>
```

Explain where TLS terminates in your chosen controller design.

## Cleanup

```bash
kubectl delete namespace ingress-lab
```
