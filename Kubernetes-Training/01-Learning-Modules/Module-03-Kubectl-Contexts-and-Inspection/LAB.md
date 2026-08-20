# Module 03 — kubectl, Contexts and Cluster Inspection: Hands-On Lab

## Objective
Practice safe cluster navigation and output formats.

```bash
kubectl config get-contexts
kubectl config current-context
kubectl config view --minify
kubectl get ns
```

Create a namespace and make it the current default:

```bash
kubectl create namespace context-lab
kubectl config set-context --current --namespace=context-lab
kubectl config view --minify | grep namespace
```

Practice outputs:

```bash
kubectl get pods -o wide
kubectl get nodes -o name
kubectl get nodes -o custom-columns=NAME:.metadata.name,KUBELET:.status.nodeInfo.kubeletVersion
kubectl get nodes -o jsonpath='{.items[*].metadata.name}'; echo
```

Return to default and cleanup:

```bash
kubectl config set-context --current --namespace=default
kubectl delete namespace context-lab
```
