# Module 04 — Hands-On Lab

## Prerequisite

```bash
kubectl get nodes
```

All nodes should be `Ready`.

## Lab 1 — Discover APIs

```bash
kubectl api-resources
kubectl api-resources --namespaced=true
kubectl api-resources --namespaced=false
kubectl api-versions
```

Find the API versions and scope for Pod, Deployment, Service, Node, and StorageClass.

## Lab 2 — Discover Fields

```bash
kubectl explain pod
kubectl explain pod.spec
kubectl explain pod.spec.containers
kubectl explain service.spec.type
```

## Lab 3 — Pod YAML

```bash
kubectl apply -f examples/01-pod-complete.yaml
kubectl get pod yaml-demo -o wide
kubectl describe pod yaml-demo
kubectl get pod yaml-demo -o yaml
```

Find both `spec` and `status`.

## Lab 4 — Generate YAML

```bash
kubectl create deployment generated-demo \
  --image=nginx:1.28-alpine \
  --dry-run=client \
  -o yaml > /tmp/generated-deployment.yaml
cat /tmp/generated-deployment.yaml
```

Identify `apiVersion`, `kind`, `metadata`, `spec`, `selector`, `template`, and `containers`.

## Lab 5 — Server Dry Run and Apply

```bash
kubectl apply --dry-run=server -f examples/02-deployment-complete.yaml
kubectl apply -f examples/02-deployment-complete.yaml
kubectl get deployment yaml-web
kubectl get rs
kubectl get pods -l app=yaml-web
```

## Lab 6 — Service

```bash
kubectl apply -f examples/03-service-complete.yaml
kubectl get svc yaml-web
kubectl describe svc yaml-web
```

## Lab 7 — Multi-Object YAML

```bash
kubectl apply -f examples/04-multi-object.yaml
kubectl get namespace yaml-lab
kubectl get configmap -n yaml-lab
kubectl get pod -n yaml-lab
```

## Lab 8 — Intentional Failure

Copy the Pod manifest and change `kind: Pod` to `kind: Pood`.

```bash
cp examples/01-pod-complete.yaml /tmp/broken.yaml
nano /tmp/broken.yaml
kubectl apply -f /tmp/broken.yaml
```

Troubleshoot using:

```bash
kubectl api-resources | grep -i pod
```

## Cleanup

```bash
kubectl delete -f examples/ --ignore-not-found
```
