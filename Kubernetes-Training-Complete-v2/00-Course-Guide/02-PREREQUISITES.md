# Prerequisites

## Knowledge

Students should know basic Linux, networking, Docker and Git before starting Kubernetes.

## Tools

```bash
kubectl version --client
aws --version
docker --version
git --version
```

For EKS:

```bash
aws sts get-caller-identity
eksctl version
helm version
```

## Linux Skills Expected

```bash
pwd
ls -la
cat /etc/os-release
ip addr
ip route
ss -lntp
systemctl status containerd
journalctl -u kubelet
curl -I https://kubernetes.io
```

## AWS Skills Expected

Students should understand VPC, subnet, route table, Internet Gateway/NAT Gateway, Security Groups, EC2, IAM and Load Balancers before the EKS module.
