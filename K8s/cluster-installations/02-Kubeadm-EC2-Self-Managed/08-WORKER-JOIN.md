# 08 — Join Worker Nodes

Run the join command on both workers:

```bash
sudo kubeadm join <CONTROL-PLANE-PRIVATE-IP>:6443   --token <TOKEN>   --discovery-token-ca-cert-hash sha256:<HASH>
```

If lost, create a new join command on control plane:

```bash
kubeadm token create --print-join-command
```

Validate:

```bash
kubectl get nodes -o wide
```

Optional labels:

```bash
kubectl label node worker-01 node-role.kubernetes.io/worker=worker
kubectl label node worker-02 node-role.kubernetes.io/worker=worker
```
