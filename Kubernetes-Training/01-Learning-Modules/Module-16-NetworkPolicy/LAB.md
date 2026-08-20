# Module 16 — NetworkPolicy: Hands-On Lab

## Objective
Prove both allowed and denied traffic. Requires a CNI that enforces NetworkPolicy.

```bash
kubectl create namespace policy-lab
kubectl create deployment web --image=nginx:alpine -n policy-lab
kubectl expose deployment web --port=80 -n policy-lab
kubectl run client --image=curlimages/curl --command -n policy-lab -- sleep 3600
```

Baseline:

```bash
kubectl exec -n policy-lab client -- curl -sS http://web
```

Apply default-deny ingress:

```bash
kubectl apply -n policy-lab -f examples/default-deny.yaml
kubectl exec -n policy-lab client -- curl -m 3 http://web || echo 'blocked as expected'
```

Label the client and add an allow policy:

```bash
kubectl label pod client role=client -n policy-lab
cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-client-to-web
  namespace: policy-lab
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes: [Ingress]
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: client
      ports:
        - protocol: TCP
          port: 80
EOF

kubectl exec -n policy-lab client -- curl -m 3 http://web
```

If traffic is still allowed after the ingress default deny, determine whether your CNI enforces NetworkPolicy.

Optional egress lesson: add an Egress policy for the client. When you deny egress, remember that the client also needs DNS (TCP/UDP 53) in addition to application traffic; otherwise the Service name cannot resolve.

```bash
kubectl delete namespace policy-lab
```
