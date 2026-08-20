# 9. Validate the kubeadm Cluster

## Cluster Health

```bash
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp | tail -30
```

## API Ready Check

```bash
kubectl get --raw='/readyz?verbose'
```

## Cross-Node Pod Test

```bash
kubectl create deployment web-test --image=nginx:alpine --replicas=3
kubectl get pods -o wide
kubectl expose deployment web-test --port=80 --target-port=80 --type=ClusterIP
kubectl get svc web-test
```

Run a disposable client:

```bash
kubectl run curl-test --rm -it --restart=Never --image=curlimages/curl -- \
  curl -sS http://web-test
```

If you receive the Nginx HTML response, Pod networking + Service discovery are functioning.

Cleanup:

```bash
kubectl delete deployment web-test
kubectl delete service web-test
```
