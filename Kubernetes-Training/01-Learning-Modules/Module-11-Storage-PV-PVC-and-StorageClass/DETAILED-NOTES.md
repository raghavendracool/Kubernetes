# Detailed Notes — Storage

## Object Relationship

```text
Pod -> PVC -> PV -> storage backend
             ^
             |
        StorageClass / CSI provisioning
```

A Pod references a PVC, not normally an AWS EBS volume ID directly.

## Access Modes

Common modes include `ReadWriteOnce`, `ReadOnlyMany`, and `ReadWriteMany`; what is actually supported depends on the storage system/CSI driver.

## Reclaim Policy

When a PVC/PV lifecycle ends, the StorageClass/PV reclaim behavior influences whether backing storage is deleted or retained. For valuable data, understand this before cleanup.

## Cloud Topology

EBS volumes are Availability Zone scoped. A Pod with an EBS-backed PVC must run where the volume can attach. This is why storage topology and scheduler decisions are connected.

## Debug Pending PVC

```bash
kubectl describe pvc <name>
kubectl get storageclass -o yaml
kubectl get pods -n kube-system | grep -i csi
kubectl get events --sort-by=.lastTimestamp
```
