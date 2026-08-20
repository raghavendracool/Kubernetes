# 8. Join Worker Nodes

Run the join command on **each worker**.

Example shape:

```bash
sudo kubeadm join <CONTROL_PLANE_PRIVATE_IP>:6443 \
  --token <TOKEN> \
  --discovery-token-ca-cert-hash sha256:<HASH>
```

If the original token expired, generate a fresh command on the control plane:

```bash
kubeadm token create --print-join-command
```

## Verify from Control Plane

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
```

Expected topology:

```text
k8s-cp-01       Ready    control-plane
k8s-worker-01   Ready    <none>
k8s-worker-02   Ready    <none>
```

## Check kubelet on a Worker if Join Fails

```bash
sudo systemctl status kubelet --no-pager
sudo journalctl -u kubelet -n 100 --no-pager
sudo systemctl status containerd --no-pager
```
