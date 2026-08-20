# Detailed Notes — Security and Day-2 Operations

## Pod Security

Prefer workloads that:

- run as non-root;
- cannot gain extra privileges;
- drop Linux capabilities not required;
- use RuntimeDefault seccomp where compatible;
- mount only required volumes;
- use trusted, patched, immutable image tags/digests.

## Access

Review RBAC and EKS access regularly. Human access should use short-lived/federated cloud credentials rather than static IAM keys.

## Node Maintenance

```text
cordon -> stop new scheduling
drain  -> evict movable workloads while respecting controls
patch/replace node
validate
uncordon -> allow scheduling again
```

## Upgrades

Before upgrading:

1. inventory versions;
2. check removed/deprecated APIs;
3. check CNI/CSI/Ingress/metrics compatibility;
4. verify PDB and capacity;
5. test in non-production;
6. upgrade according to supported version-skew rules;
7. validate application and platform telemetry.

## Backup

Self-managed clusters require explicit etcd/control-plane recovery planning. EKS manages control-plane infrastructure, but application data, manifests, cloud resources and workload recovery are still your responsibility.
