# The 3 Whys of Kubernetes

## WHY 1 — Docker Solves Packaging, Not Fleet Orchestration

```text
Source Code → Dockerfile → Image → Container
```

Now scale the production problem:

```text
20 servers
100 containers
10 applications
multiple versions
traffic spikes
node failures
container crashes
network changes
storage requirements
different team permissions
```

A human cannot reliably SSH to each server and continuously maintain desired state.

## WHY 2 — Production Needs Automation

Questions Kubernetes answers:

- Which node should run the next workload?
- How many copies should exist?
- What happens if a Pod dies?
- What happens if a node dies?
- How do apps find each other?
- How do users reach healthy replicas?
- How do we roll out version v2?
- How do we roll back?
- How do we control user/workload permissions?
- How do we request persistent storage?

## WHY 3 — Kubernetes Is a Declarative Control System

```text
Declare Desired State
        ↓
API Server
        ↓
Persist Cluster State
        ↓
Controllers Compare Actual vs Desired
        ↓
Take Corrective Action
        ↓
Repeat
```
