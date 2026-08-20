# Detailed Notes — Kubernetes Foundation

## From One Container to an Orchestrated Platform

Docker solves the problem of packaging and running a container. Kubernetes solves the operational problems that appear when you have many containers, many servers and continuous application changes. If one server fails, Kubernetes can recreate affected workload replicas elsewhere. If traffic increases, replicas can be scaled. If a release is unhealthy, a Deployment can be rolled back.

The important shift is from **imperative server management** to **declarative desired state**.

```text
Imperative: "SSH to server-2 and start another container."
Declarative: "I want 3 replicas of this application."
```

Kubernetes controllers compare desired state with actual state continuously. This loop is called **reconciliation**.

## Core Vocabulary

- **Cluster** — the complete Kubernetes environment.
- **Control plane** — API and controllers that manage state.
- **Node** — a machine registered to the cluster.
- **Pod** — smallest normal scheduling unit.
- **Workload** — application/batch resource such as Deployment, StatefulSet or Job.
- **Service** — stable endpoint in front of Pods.
- **Namespace** — logical scope for resources.
- **Controller** — software that watches desired/actual state and reconciles differences.

## Kubernetes Does Not Replace Everything

Kubernetes still needs:

- container images and a registry;
- a container runtime on nodes;
- networking/CNI;
- persistent storage/CSI when state is required;
- an ingress/load-balancing implementation for external traffic;
- monitoring, logging and security processes.

## Desired-State Example

If a Deployment says `replicas: 3` and one Pod is deleted, Kubernetes sees actual replicas = 2 while desired replicas = 3. The ReplicaSet controller creates a replacement. The operator does not need to manually recreate the deleted Pod.

This is the first idea students should be able to explain before learning YAML syntax.
