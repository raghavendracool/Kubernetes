# Module 18 — Autoscaling, Availability and PDB: Hands-On Lab

## Objective
Use HPA and PDB against a Deployment with resource requests.

```bash
kubectl create namespace scale-lab
kubectl create deployment web --image=nginx:alpine --replicas=2 -n scale-lab
kubectl set resources deployment web -n scale-lab --requests=cpu=50m,memory=64Mi --limits=cpu=200m,memory=128Mi
kubectl autoscale deployment web -n scale-lab --cpu-percent=60 --min=2 --max=6
kubectl get hpa -n scale-lab
```

If Metrics Server is installed:

```bash
kubectl top pods -n scale-lab
kubectl describe hpa web -n scale-lab
```

Create a PDB:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: web-pdb
  namespace: scale-lab
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: web
EOF

kubectl get pdb -n scale-lab
```

Explain why HPA scaling and node scaling solve different problems.

```bash
kubectl delete namespace scale-lab
```
