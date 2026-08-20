# 10. Use kubectl from Your Admin Workstation

Do **not** copy `admin.conf` into public/shared locations. Treat it as a cluster-admin credential.

For a lab, you can securely copy the kubeconfig from the control plane to your workstation, then update the server endpoint so it is reachable from your workstation.

Example copy:

```bash
scp -i <key.pem> ubuntu@<control-plane-host>:/home/ubuntu/.kube/config ./kubeadm-lab-config
```

Use it temporarily:

```bash
export KUBECONFIG=$PWD/kubeadm-lab-config
kubectl config current-context
kubectl get nodes
```

For real environments, create separate user identities/certificates and RBAC rather than distributing the cluster-admin kubeconfig.
