# Detailed Notes — Autoscaling and Availability

## HPA Calculation Idea

For resource utilization, HPA compares observed utilization with target utilization and changes replica count within min/max boundaries. Resource requests are important because CPU utilization percentage needs a request baseline.

## Capacity Scaling

More Pod replicas do not help when there is no node capacity to schedule them. That is the separate responsibility of Cluster Autoscaler, Karpenter, EKS Auto Mode or another node/capacity system.

## PDB

A PodDisruptionBudget limits **voluntary** disruptions, such as node drain. It does not prevent hardware failure, process crash or all involuntary outages.

## Availability Stack

```text
multiple replicas
+ readiness probes
+ spread/anti-affinity
+ PDB
+ enough node/AZ capacity
+ autoscaling
+ tested failure behavior
```

No single field creates high availability.
