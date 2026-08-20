# 7. Install Calico CNI

Run on the control-plane node after kubeadm initialization.

This course uses the Calico operator installation and the `192.168.0.0/16` Pod network used during `kubeadm init`.

## Install CRDs and Operator

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/v1_crd_projectcalico_org.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/tigera-operator.yaml
```

## Download Custom Resources

```bash
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/custom-resources.yaml
```

Inspect before applying:

```bash
grep -n -A5 -B5 'cidr:' custom-resources.yaml
```

Ensure the configured IP pool matches the intended Pod CIDR for your lab, then create it:

```bash
kubectl create -f custom-resources.yaml
```

## Watch CNI Readiness

```bash
kubectl get pods -A -w
```

In another terminal:

```bash
kubectl get tigerastatus
kubectl get nodes -o wide
```

Do not continue until the control-plane node becomes `Ready` and Calico components are healthy.
