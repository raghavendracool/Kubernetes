# Detailed Notes — NetworkPolicy

## Default Behavior

Without an enforcing isolation policy, Pod traffic is generally not restricted by Kubernetes NetworkPolicy. Once a Pod is selected for ingress or egress policy types, only explicitly allowed traffic for that direction is permitted according to combined applicable policies.

## Default Deny

A common design begins with default deny and then adds required flows. In a live environment, introducing default deny without mapping dependencies can cause an outage.

## DNS Is a Dependency

If egress becomes isolated and DNS is not allowed, applications may report that every hostname is broken even though network routes exist.

## Selector Reasoning

A policy can select:

- Pods in the same namespace by pod labels;
- namespaces by namespace labels;
- Pod + namespace combinations;
- IP blocks for external ranges.

Test allowed **and denied** cases. A policy is incomplete if you only prove the happy path.
