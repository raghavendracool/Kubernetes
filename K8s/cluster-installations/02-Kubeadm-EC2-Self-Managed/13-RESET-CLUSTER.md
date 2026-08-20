# 13 — Reset Training Cluster

Only when intentionally resetting:

```bash
sudo kubeadm reset -f
rm -rf $HOME/.kube
```

CNI cleanup can require plugin-specific steps.

Finally terminate training EC2 resources and verify there are no leftovers.
