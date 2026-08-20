# Control Plane Components

## kube-apiserver — Front Door

Everything uses the Kubernetes API.

```text
kubectl
controllers
scheduler
kubelets
operators
       ↓
  kube-apiserver
```

## etcd — Cluster State Database

Stores Kubernetes API data.

Do not confuse it with application data.

```text
PostgreSQL/MySQL → app business data
etcd             → Kubernetes cluster state
```

## kube-scheduler — Placement Decision

Main question:

> Which eligible node should run this unscheduled Pod?

It considers resource requests and scheduling constraints.

## kube-controller-manager — Reconciliation

Example:

```text
Desired replicas = 3
Actual replicas  = 2
        ↓
Controller acts
        ↓
Replacement workload created
```

## cloud-controller-manager

Separates cloud-provider integration control loops from core Kubernetes logic.
