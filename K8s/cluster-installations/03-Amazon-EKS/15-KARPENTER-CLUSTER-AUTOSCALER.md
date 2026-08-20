# 15 — Node Autoscaling

```text
HPA increases Pod demand
      ↓
Pods become Pending if insufficient capacity
      ↓
Node autoscaler
      ↓
More EC2 capacity
```

Teach both:
- Cluster Autoscaler — scales configured node groups.
- Karpenter — provisions capacity based on workload scheduling requirements.

Use current project/AWS installation docs because versions/APIs change.
