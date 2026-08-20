# 07 — Install Calico CNI

Course baseline: Calico 3.32.x. Re-check official docs before class.

Pinned classroom example:

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/v1_crd_projectcalico_org.yaml

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/tigera-operator.yaml

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/custom-resources.yaml
```

Validate:

```bash
kubectl get pods -A
kubectl get tigerastatus
kubectl get nodes
```
