# 11. kubeadm Troubleshooting

## Node NotReady

```bash
kubectl describe node <node>
sudo systemctl status kubelet --no-pager
sudo journalctl -u kubelet -n 200 --no-pager
sudo systemctl status containerd --no-pager
```

Look for CNI, runtime, certificate, disk/memory pressure or network problems.

## kubeadm init Preflight Errors

```bash
sudo kubeadm reset -f
sudo systemctl restart containerd
sudo systemctl restart kubelet
```

Do not use `--ignore-preflight-errors=all` as the normal fix. Understand the failed preflight check.

## API Server Not Reachable

On control plane:

```bash
sudo ss -lntp | grep 6443
sudo crictl ps -a | grep kube-apiserver
sudo crictl logs <api-server-container-id>
```

From another node:

```bash
nc -vz <control-plane-private-ip> 6443
```

## Pods Pending After CNI Install

```bash
kubectl get pods -A -o wide
kubectl get tigerastatus
kubectl get events -A --sort-by=.lastTimestamp
```

## CoreDNS Pending

CoreDNS often remains Pending/NotReady when the cluster network is not ready. Fix CNI/node readiness first instead of restarting CoreDNS repeatedly.
