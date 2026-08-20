# 12 — Troubleshooting

Node:

```bash
kubectl describe node <node>
sudo systemctl status kubelet --no-pager
sudo journalctl -u kubelet -n 200 --no-pager
sudo systemctl status containerd --no-pager
```

CNI:

```bash
kubectl get tigerastatus
kubectl get pods -A
```

API:

```bash
curl -k https://<control-plane-ip>:6443/readyz
sudo ss -lntp | grep 6443
```

DNS:

```bash
kubectl get pods -n kube-system | grep coredns
kubectl logs -n kube-system deployment/coredns
```
