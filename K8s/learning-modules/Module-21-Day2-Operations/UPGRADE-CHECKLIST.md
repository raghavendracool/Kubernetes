# kubeadm Upgrade Checklist

1. Read release notes.
2. Check version skew.
3. Back up etcd.
4. Verify applications/PDBs.
5. Upgrade one control-plane node at a time.
6. Upgrade kubeadm first.
7. Run `kubeadm upgrade plan`.
8. Apply supported upgrade.
9. Drain node before kubelet/runtime maintenance.
10. Upgrade kubelet/kubectl.
11. Restart kubelet.
12. Uncordon.
13. Validate.
14. Upgrade workers one at a time.
15. Never skip Kubernetes minor versions.
