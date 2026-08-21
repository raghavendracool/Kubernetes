# Module 04 — Command Sheet

## API Discovery

```bash
kubectl api-resources
kubectl api-resources -o wide
kubectl api-resources --namespaced=true
kubectl api-resources --namespaced=false
kubectl api-versions
```

## Explain Schema

```bash
kubectl explain pod
kubectl explain pod.spec
kubectl explain pod.spec.containers
kubectl explain deployment.spec
kubectl explain service.spec.type
kubectl explain deployment --recursive
```

## Generate YAML

```bash
kubectl run nginx --image=nginx:1.28-alpine --dry-run=client -o yaml
kubectl run nginx --image=nginx:1.28-alpine --dry-run=client -o yaml > pod.yaml
kubectl create deployment web --image=nginx:1.28-alpine --dry-run=client -o yaml > deployment.yaml
kubectl create service clusterip web --tcp=80:80 --dry-run=client -o yaml > service.yaml
```

## Validate / Diff / Apply

```bash
kubectl apply --dry-run=client -f pod.yaml
kubectl apply --dry-run=server -f pod.yaml
kubectl diff -f pod.yaml
kubectl apply -f pod.yaml
kubectl apply -f examples/
```

## Inspect

```bash
kubectl get pods
kubectl get pod nginx -o yaml
kubectl get pod nginx -o json
kubectl get pods -o name
kubectl describe pod nginx
```

## Custom Output

```bash
kubectl get pods -o custom-columns=NAME:.metadata.name,PHASE:.status.phase,NODE:.spec.nodeName
kubectl get pod nginx -o jsonpath='{.status.podIP}'
```

## CRDs

```bash
kubectl get crd
```

## Cleanup

```bash
kubectl delete -f pod.yaml --ignore-not-found
kubectl delete -f examples/ --ignore-not-found
```
