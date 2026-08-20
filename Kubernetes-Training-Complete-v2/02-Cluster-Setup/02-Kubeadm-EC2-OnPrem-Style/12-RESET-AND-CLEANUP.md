# 12. Reset and Cleanup

Run on workers first, then control plane when destroying the lab.

```bash
sudo kubeadm reset -f
sudo systemctl stop kubelet
sudo rm -rf /etc/cni/net.d
sudo rm -rf $HOME/.kube
```

Optional network cleanup if a broken lab leaves CNI interfaces behind:

```bash
ip link show
sudo ip link delete cni0 2>/dev/null || true
sudo ip link delete flannel.1 2>/dev/null || true
```

Then terminate the EC2 instances and remove lab Security Groups/VPC resources if they are no longer required.

## Do not forget AWS cost cleanup

```bash
aws ec2 describe-instances \
  --filters 'Name=instance-state-name,Values=running' \
  --query 'Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,Type:InstanceType}' \
  --output table
```
