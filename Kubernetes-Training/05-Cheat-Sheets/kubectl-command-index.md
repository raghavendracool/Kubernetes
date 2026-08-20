# kubectl Command Index

## Context

```bash
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <context>
kubectl config set-context --current --namespace=<namespace>
```

## Discovery

```bash
kubectl cluster-info
kubectl api-resources
kubectl api-versions
kubectl explain deployment
kubectl explain deployment.spec.template.spec.containers
```

## Get

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get deploy,rs,pods -n <namespace>
kubectl get svc,endpointslice -n <namespace>
kubectl get events -A --sort-by=.lastTimestamp
```

## Debug

```bash
kubectl describe pod <pod> -n <namespace>
kubectl logs <pod> -n <namespace>
kubectl logs <pod> -n <namespace> --previous
kubectl exec -it <pod> -n <namespace> -- sh
kubectl port-forward pod/<pod> 8080:80 -n <namespace>
kubectl debug -it pod/<pod> --image=busybox:1.36 --target=<container>
```

## Deployments

```bash
kubectl rollout status deployment/<name>
kubectl rollout history deployment/<name>
kubectl set image deployment/<name> <container>=<image:tag>
kubectl rollout undo deployment/<name>
kubectl scale deployment/<name> --replicas=3
```

## Apply / Diff / Dry Run

```bash
kubectl apply --dry-run=server -f file.yaml
kubectl diff -f file.yaml
kubectl apply -f file.yaml
kubectl delete -f file.yaml
```

## RBAC

```bash
kubectl auth can-i get pods
kubectl auth can-i --list
kubectl auth can-i list pods --as=system:serviceaccount:dev:app-reader -n dev
```

## Nodes

```bash
kubectl cordon <node>
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data
kubectl uncordon <node>
kubectl describe node <node>
```
