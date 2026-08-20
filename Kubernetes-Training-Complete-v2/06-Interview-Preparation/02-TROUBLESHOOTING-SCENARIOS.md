# Kubernetes Interview — Troubleshooting Scenarios

## Scenario: Service returns connection refused

Check in order:

```bash
kubectl get svc <svc> -o yaml
kubectl get endpointslices -l kubernetes.io/service-name=<svc>
kubectl get pods -l app=<label> -o wide
kubectl describe pod <pod>
kubectl exec <pod> -- ss -lnt
```

Look for selector mismatch, not-ready Pods, wrong targetPort, or application not listening.

## Scenario: Pod is CrashLoopBackOff

```bash
kubectl describe pod <pod>
kubectl logs <pod> --all-containers
kubectl logs <pod> --previous
```

Check entrypoint, config, secrets, dependencies, OOM and probes.

## Scenario: Node NotReady

```bash
kubectl describe node <node>
systemctl status kubelet
journalctl -u kubelet -n 200
systemctl status containerd
```

Then inspect runtime, CNI, disk/memory pressure and network connectivity.

## Scenario: EKS engineer gets Forbidden

Separate authentication from authorization:

```bash
aws sts get-caller-identity
aws eks list-access-entries --cluster-name <cluster>
kubectl auth can-i get pods -A
```

The IAM principal may authenticate but still lack the EKS access policy/Kubernetes RBAC required for the action.
