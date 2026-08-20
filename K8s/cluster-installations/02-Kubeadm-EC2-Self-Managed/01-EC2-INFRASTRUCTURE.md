# 01 — EC2 Infrastructure

Suggested classroom sizing:

| Node | Type | OS |
|---|---|---|
| control-plane | t3.medium | Ubuntu 24.04 |
| worker-01 | t3.medium | Ubuntu 24.04 |
| worker-02 | t3.medium | Ubuntu 24.04 |

Set hostnames on the matching server:

```bash
sudo hostnamectl set-hostname control-plane
sudo hostnamectl set-hostname worker-01
sudo hostnamectl set-hostname worker-02
```

Record private IPs:

```bash
hostname -I
ip addr
```
