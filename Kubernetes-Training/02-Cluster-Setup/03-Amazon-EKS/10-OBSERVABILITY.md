# 10. EKS Observability

## Enable Control Plane Logs

```bash
aws eks update-cluster-config \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --logging '{"clusterLogging":[{"types":["api","audit","authenticator","controllerManager","scheduler"],"enabled":true}]}'
```

Check status:

```bash
aws eks describe-update \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --update-id <UPDATE_ID>
```

## Kubernetes-side Checks

```bash
kubectl get events -A --sort-by=.lastTimestamp
kubectl top nodes
kubectl top pods -A
kubectl get pods -n kube-system -o wide
```

Production monitoring normally adds Prometheus-compatible metrics, dashboards, centralized logs and alerting tied to SLOs.
