# Kubernetes for DevOps Engineers — Printable Master Notes

This single file combines each module's teaching notes, command sheet and hands-on lab, followed by the self-managed kubeadm and Amazon EKS tracks. Application source code remains separate under `03-Applications`.


---

# Module 01 — Kubernetes Foundation

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes is a platform for running and operating containerized applications across one or more machines. Instead of manually starting containers and deciding where they run, you declare the state you want—such as three replicas of an API—and Kubernetes continuously works to keep the cluster at that state.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- Why container orchestration is required
- Desired state and reconciliation
- Cluster, node, pod and workload terminology
- Kubernetes versus Docker/Compose

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Kubernetes is an orchestrator, not a container runtime.
- You declare desired state; controllers continuously reconcile actual state.
- The Pod is the smallest normal deployable unit.

## 6. Core Commands

| Task | Command |
|---|---|
| Inspect kubectl client | `kubectl version --client` |
| View cluster information | `kubectl cluster-info` |
| List API resources | `kubectl api-resources` |
| List API versions | `kubectl api-versions` |
| Explain a resource | `kubectl explain pod` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| kubectl command not found | Install kubectl and ensure it is on PATH. |
| Unable to connect to server | No valid kubeconfig/context or cluster is unavailable. |
| Confusing Docker with Kubernetes | Docker/containerd run containers; Kubernetes schedules and manages workloads across nodes. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

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


---

# Module 01 — Kubernetes Foundation: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Inspect kubectl client

```bash
kubectl version --client
```

**Why:** Use this when you need to inspect kubectl client. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### View cluster information

```bash
kubectl cluster-info
```

**Why:** Use this when you need to view cluster information. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List API resources

```bash
kubectl api-resources
```

**Why:** Use this when you need to list api resources. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List API versions

```bash
kubectl api-versions
```

**Why:** Use this when you need to list api versions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Explain a resource

```bash
kubectl explain pod
```

**Why:** Use this when you need to explain a resource. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 01 — Kubernetes Foundation: Hands-On Lab

## Objective
Build a mental map of the cluster without creating an application.

```bash
kubectl version --client
kubectl cluster-info
kubectl get nodes -o wide
kubectl api-resources
kubectl api-versions
kubectl get namespaces
```

Choose five resources from `kubectl api-resources` and answer: namespaced or cluster-scoped? API group? short name?

```bash
kubectl explain pod
kubectl explain deployment
kubectl explain service
```

### Pass Criteria
- Explain desired state and reconciliation.
- Identify cluster, node, namespace and Pod concepts.
- Explain why kubectl needs a reachable API server and kubeconfig.


---

# Module 02 — Kubernetes Architecture

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

A Kubernetes cluster is split into a control plane, which stores and decides cluster state, and worker nodes, which run application Pods. Understanding the API server, etcd, scheduler, controller manager, kubelet, container runtime, CNI and service networking is essential for troubleshooting because each failure maps to a different part of this architecture.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- Control plane components
- Worker-node components
- API request flow
- etcd, scheduler and controllers
- kubelet, kube-proxy and container runtime

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- API Server is the front door of the cluster.
- etcd stores cluster state.
- Scheduler selects a node; kubelet makes the Pod run on that node.

## 6. Core Commands

| Task | Command |
|---|---|
| Show component health signals | `kubectl get --raw='/readyz?verbose'` |
| List nodes | `kubectl get nodes -o wide` |
| Inspect system pods | `kubectl get pods -n kube-system -o wide` |
| Describe node | `kubectl describe node <node-name>` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Node NotReady | Check kubelet, runtime, CNI and node conditions. |
| CoreDNS Pending | Check node readiness, CNI and resource availability. |
| API timeout | Check endpoint reachability, authentication and control-plane health. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Kubernetes Architecture

## Control Plane

### kube-apiserver

All normal cluster operations flow through the API server. kubectl, controllers, schedulers and many extensions communicate with the API, not by editing etcd directly.

### etcd

etcd is the strongly consistent key-value database that stores Kubernetes cluster state. In self-managed Kubernetes, etcd backup/recovery is part of your responsibility. In EKS the control-plane data store is managed by AWS.

### kube-scheduler

The scheduler watches for Pods without a node assignment. It filters nodes that cannot satisfy requirements, scores remaining candidates and writes the selected node into the Pod specification.

### kube-controller-manager

This runs core reconciliation controllers: Deployment/ReplicaSet-related behavior, nodes, endpoints and many other desired-state loops.

## Worker Node

### kubelet

The kubelet watches Pods assigned to its node and ensures their containers are created and kept in the expected state. When a node is NotReady, kubelet health is one of the first checks.

### Container Runtime

containerd commonly pulls images, creates containers and reports runtime state through the CRI integration used by kubelet.

### Networking

CNI configures Pod network interfaces/IPs. Service routing is implemented by kube-proxy or another supported dataplane. CoreDNS provides service discovery.

## Follow a Deployment

```text
kubectl -> API Server -> stored desired state
                    -> Deployment controller -> ReplicaSet
                    -> ReplicaSet controller -> Pods
                    -> Scheduler -> node assignment
                    -> kubelet -> containerd -> containers
                    -> CNI -> Pod network
```

During a demo, watch `Deployment`, `ReplicaSet`, `Pod` and events together to make this architecture visible.


---

# Module 02 — Kubernetes Architecture: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show component health signals

```bash
kubectl get --raw='/readyz?verbose'
```

**Why:** Use this when you need to show component health signals. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List nodes

```bash
kubectl get nodes -o wide
```

**Why:** Use this when you need to list nodes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect system pods

```bash
kubectl get pods -n kube-system -o wide
```

**Why:** Use this when you need to inspect system pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe node

```bash
kubectl describe node <node-name>
```

**Why:** Use this when you need to describe node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 02 — Kubernetes Architecture: Hands-On Lab

## Objective
Observe control-plane and node components through Kubernetes-visible evidence.

```bash
kubectl get nodes -o wide
kubectl get pods -n kube-system -o wide
kubectl get --raw='/readyz?verbose'
kubectl describe node $(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
```

Create a tiny Deployment and watch object creation:

```bash
kubectl create namespace arch-lab
kubectl create deployment web --image=nginx:alpine -n arch-lab
kubectl get deployment,rs,pods -n arch-lab -w
```

In a second terminal:

```bash
kubectl get events -n arch-lab --sort-by=.lastTimestamp -w
```

Explain the sequence Deployment → ReplicaSet → Pod → scheduler → kubelet.

```bash
kubectl delete namespace arch-lab
```


---

# Module 03 — kubectl, Contexts and Cluster Inspection

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

kubectl is the main command-line client for the Kubernetes API. A kubeconfig file tells kubectl which cluster endpoint to contact, which identity to use and which context/namespace is active. Context awareness is a production safety skill because the same command can affect dev, QA or production depending on the selected context.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- kubeconfig structure
- contexts, clusters and users
- namespaces
- output formats and JSONPath
- safe read-only inspection

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Always confirm your context before making changes.
- `-n` selects a namespace; `-A` means all namespaces.
- Use `-o yaml`, JSONPath and custom columns for automation.

## 6. Core Commands

| Task | Command |
|---|---|
| Show current context | `kubectl config current-context` |
| List contexts | `kubectl config get-contexts` |
| Switch context | `kubectl config use-context <context-name>` |
| Set default namespace | `kubectl config set-context --current --namespace=<namespace>` |
| Get all pods with details | `kubectl get pods -A -o wide` |
| JSONPath example | `kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.nodeInfo.kubeletVersion}{"\n"}{end}'` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Changed wrong cluster | Run `kubectl config current-context` before apply/delete. |
| Resource not found | Check namespace and spelling. |
| Forbidden | Authentication succeeded but authorization/RBAC denied the action. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — kubectl, Contexts and Inspection

## kubeconfig Structure

A kubeconfig normally contains three reusable lists:

- `clusters`: API endpoints and CA information;
- `users`: credentials/authentication methods;
- `contexts`: a cluster + user + optional default namespace combination.

The current context determines where kubectl sends commands.

## Production Safety Habit

Before `apply`, `delete`, `scale`, `rollout undo` or `drain`, run:

```bash
kubectl config current-context
kubectl config view --minify
```

A valid command against the wrong context is still a serious incident.

## Resource Discovery

Do not guess plural names or API groups:

```bash
kubectl api-resources
kubectl api-resources --api-group=apps
kubectl explain deployment
kubectl explain deployment.spec.strategy
```

## Read-Only Inspection Patterns

```bash
kubectl get pods -A -o wide
kubectl get deployment -A
kubectl get pod <name> -o yaml
kubectl describe pod <name>
kubectl get events --sort-by=.lastTimestamp
```

`get` is best for inventory/state. `describe` combines relevant fields, conditions and events. `-o yaml/json` is best when you need the exact object representation.


---

# Module 03 — kubectl, Contexts and Cluster Inspection: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show current context

```bash
kubectl config current-context
```

**Why:** Use this when you need to show current context. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List contexts

```bash
kubectl config get-contexts
```

**Why:** Use this when you need to list contexts. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Switch context

```bash
kubectl config use-context <context-name>
```

**Why:** Use this when you need to switch context. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Set default namespace

```bash
kubectl config set-context --current --namespace=<namespace>
```

**Why:** Use this when you need to set default namespace. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Get all pods with details

```bash
kubectl get pods -A -o wide
```

**Why:** Use this when you need to get all pods with details. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### JSONPath example

```bash
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.nodeInfo.kubeletVersion}{"\n"}{end}'
```

**Why:** Use this when you need to jsonpath example. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 03 — kubectl, Contexts and Cluster Inspection: Hands-On Lab

## Objective
Practice safe cluster navigation and output formats.

```bash
kubectl config get-contexts
kubectl config current-context
kubectl config view --minify
kubectl get ns
```

Create a namespace and make it the current default:

```bash
kubectl create namespace context-lab
kubectl config set-context --current --namespace=context-lab
kubectl config view --minify | grep namespace
```

Practice outputs:

```bash
kubectl get pods -o wide
kubectl get nodes -o name
kubectl get nodes -o custom-columns=NAME:.metadata.name,KUBELET:.status.nodeInfo.kubeletVersion
kubectl get nodes -o jsonpath='{.items[*].metadata.name}'; echo
```

Return to default and cleanup:

```bash
kubectl config set-context --current --namespace=default
kubectl delete namespace context-lab
```


---

# Module 04 — Kubernetes YAML and API Objects

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes resources are API objects expressed commonly as YAML. `apiVersion` and `kind` select the API schema, `metadata` identifies the object, `spec` describes desired state, and `status` is written by Kubernetes to describe observed state. Declarative YAML makes infrastructure repeatable, reviewable and suitable for Git-based delivery.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- apiVersion, kind, metadata, spec and status
- declarative versus imperative operations
- server-side schema validation
- dry-run and diff
- resource lifecycle

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- `spec` is desired state; `status` is observed state.
- Prefer declarative YAML for repeatable environments.
- Use dry-run and diff before production changes.

## 6. Core Commands

| Task | Command |
|---|---|
| Create YAML without creating object | `kubectl create deployment demo --image=nginx --dry-run=client -o yaml` |
| Validate apply | `kubectl apply --dry-run=server -f example.yaml` |
| Preview difference | `kubectl diff -f example.yaml` |
| Apply manifest | `kubectl apply -f example.yaml` |
| Get object YAML | `kubectl get deployment demo -o yaml` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| no matches for kind | Wrong apiVersion, missing CRD or unsupported API. |
| invalid field | Check `kubectl explain <kind>.<field>`. |
| immutable field | Some object fields require recreation rather than patching. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Kubernetes YAML and API Objects

## Anatomy

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  namespace: demo
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: nginx:1.28
```

`apiVersion` + `kind` identify the schema. `metadata.name` and namespace identify the object. `spec` is the desired state.

## Why Status Is Usually Not in Git

Controllers and kubelets continuously update `status` to report observed state. You normally author `spec`; Kubernetes owns most `status` fields.

## Declarative Workflow

```bash
kubectl apply --dry-run=server -f app.yaml
kubectl diff -f app.yaml
kubectl apply -f app.yaml
```

Server-side dry run catches schema/admission problems using the actual API server. `diff` shows intended changes before mutation.

## API Lifecycle

Kubernetes APIs evolve. Before a cluster upgrade, scan manifests/Helm output for deprecated or removed versions. A manifest that worked on an old cluster may be rejected after an API removal.


---

# Module 04 — Kubernetes YAML and API Objects: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create YAML without creating object

```bash
kubectl create deployment demo --image=nginx --dry-run=client -o yaml
```

**Why:** Use this when you need to create yaml without creating object. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Validate apply

```bash
kubectl apply --dry-run=server -f example.yaml
```

**Why:** Use this when you need to validate apply. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Preview difference

```bash
kubectl diff -f example.yaml
```

**Why:** Use this when you need to preview difference. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Apply manifest

```bash
kubectl apply -f example.yaml
```

**Why:** Use this when you need to apply manifest. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Get object YAML

```bash
kubectl get deployment demo -o yaml
```

**Why:** Use this when you need to get object yaml. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 04 — Kubernetes YAML and API Objects: Hands-On Lab

## Objective
Generate, inspect, validate, diff and apply declarative YAML.

```bash
mkdir -p /tmp/yaml-lab && cd /tmp/yaml-lab
kubectl create namespace yaml-lab --dry-run=client -o yaml > namespace.yaml
kubectl create deployment web --image=nginx:alpine -n yaml-lab --dry-run=client -o yaml > deployment.yaml
```

Read the files and find `apiVersion`, `kind`, `metadata`, `spec`, selector and Pod-template labels.

```bash
kubectl apply --dry-run=server -f namespace.yaml
kubectl apply -f namespace.yaml
kubectl apply --dry-run=server -f deployment.yaml
kubectl diff -f deployment.yaml || true
kubectl apply -f deployment.yaml
kubectl get deployment web -n yaml-lab -o yaml
```

Change replicas from 1 to 3 in YAML, run `kubectl diff`, then apply.

```bash
kubectl get deploy,pods -n yaml-lab
kubectl delete namespace yaml-lab
```


---

# Module 05 — Pods and Pod Lifecycle

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

A Pod is Kubernetes' smallest normal scheduling unit. Containers in the same Pod are scheduled together, share a network namespace and can share volumes. Pods are intentionally disposable, so production Pods are normally created by controllers such as Deployments, StatefulSets or Jobs rather than managed one by one.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- Pod anatomy
- restartPolicy
- init containers and sidecars
- Pod phases and container states
- exec, logs and port-forward

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Pods are ephemeral and should normally be managed by controllers.
- A Pod can hold multiple tightly coupled containers.
- Container restart and Pod recreation are different behaviors.

## 6. Core Commands

| Task | Command |
|---|---|
| Run temporary pod | `kubectl run nginx-lab --image=nginx:alpine` |
| Inspect pod | `kubectl get pod nginx-lab -o wide` |
| Describe pod | `kubectl describe pod nginx-lab` |
| Read logs | `kubectl logs nginx-lab` |
| Execute command | `kubectl exec -it nginx-lab -- sh` |
| Delete pod | `kubectl delete pod nginx-lab` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| ImagePullBackOff | Check image name, registry access and imagePullSecrets. |
| CrashLoopBackOff | Check logs, command/args, configuration and probes. |
| Pending | Check scheduler events, resources, PVCs and taints. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Pods and Pod Lifecycle

## Why a Pod Exists

Kubernetes does not normally schedule a bare container. It schedules a Pod. All containers in that Pod are placed on the same node and share the Pod IP. Use multiple containers only when their lifecycle and locality are tightly coupled.

## Common Container Patterns

- main application container;
- init container that runs before the application;
- helper/sidecar container for tightly coupled functionality.

## States to Distinguish

Pod `phase` such as Pending/Running is not the same as container `state` such as Waiting/Running/Terminated. A Pod can be Running while one container is repeatedly crashing.

## Debug Order

```bash
kubectl get pod <pod> -o wide
kubectl describe pod <pod>
kubectl logs <pod> -c <container>
kubectl logs <pod> -c <container> --previous
kubectl exec -it <pod> -c <container> -- sh
```

Events tell you orchestration/runtime problems; logs tell you application output.

## Why Bare Pods Are Rare in Production

If you delete a bare Pod, nothing recreates it. If the same Pod template is owned by a Deployment, ReplicaSet reconciliation creates a replacement.


---

# Module 05 — Pods and Pod Lifecycle: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Run temporary pod

```bash
kubectl run nginx-lab --image=nginx:alpine
```

**Why:** Use this when you need to run temporary pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect pod

```bash
kubectl get pod nginx-lab -o wide
```

**Why:** Use this when you need to inspect pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe pod

```bash
kubectl describe pod nginx-lab
```

**Why:** Use this when you need to describe pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Read logs

```bash
kubectl logs nginx-lab
```

**Why:** Use this when you need to read logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Execute command

```bash
kubectl exec -it nginx-lab -- sh
```

**Why:** Use this when you need to execute command. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Delete pod

```bash
kubectl delete pod nginx-lab
```

**Why:** Use this when you need to delete pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 05 — Pods and Pod Lifecycle: Hands-On Lab

## Objective
Create a Pod, inspect container state, execute commands and generate a controlled failure.

```bash
kubectl create namespace pod-lab
kubectl run web --image=nginx:alpine -n pod-lab
kubectl wait --for=condition=Ready pod/web -n pod-lab --timeout=120s
kubectl get pod web -n pod-lab -o wide
kubectl describe pod web -n pod-lab
kubectl logs web -n pod-lab
kubectl exec -it web -n pod-lab -- sh
```

Create an image failure:

```bash
kubectl run bad-image --image=nginx:this-tag-does-not-exist -n pod-lab
kubectl get pods -n pod-lab -w
```

Then investigate:

```bash
kubectl describe pod bad-image -n pod-lab
kubectl get events -n pod-lab --sort-by=.lastTimestamp
```

Identify the exact event that explains `ImagePullBackOff`.

```bash
kubectl delete namespace pod-lab
```


---

# Module 06 — ReplicaSets, Deployments, Rollouts and Rollbacks

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

A Deployment describes how many interchangeable application Pods should run and how they should be updated. The Deployment controller manages ReplicaSets, and ReplicaSets maintain the requested Pod count. This hierarchy gives Kubernetes self-healing, scaling, rolling updates and rollback capability.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- Deployment desired state
- ReplicaSet ownership
- rolling update strategy
- rollout history
- rollback and scaling

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Deployment manages ReplicaSets; ReplicaSets manage Pods.
- RollingUpdate replaces Pods gradually.
- Rollback restores a previous ReplicaSet revision.

## 6. Core Commands

| Task | Command |
|---|---|
| Create deployment | `kubectl create deployment web --image=nginx:1.27` |
| Scale | `kubectl scale deployment web --replicas=3` |
| Update image | `kubectl set image deployment/web nginx=nginx:1.28` |
| Watch rollout | `kubectl rollout status deployment/web` |
| History | `kubectl rollout history deployment/web` |
| Rollback | `kubectl rollout undo deployment/web` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Rollout stuck | Check unavailable Pods, probes, quota and scheduling events. |
| Old image still running | Check rollout status and image on ReplicaSets/Pods. |
| No revision history | Use `kubectl rollout history` and set sensible revisionHistoryLimit. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Deployments, ReplicaSets and Rollouts

## Object Relationship

```text
Deployment
   |
   +--> ReplicaSet revision A --> Pods
   |
   +--> ReplicaSet revision B --> Pods   (during/after rollout)
```

You change the Deployment Pod template. Kubernetes creates a new ReplicaSet revision and gradually moves replicas.

## Rolling Update Controls

- `maxSurge`: how many extra Pods can temporarily exist.
- `maxUnavailable`: how many desired replicas can be unavailable during the rollout.

These values affect speed, capacity requirements and availability.

## Rollout Evidence

```bash
kubectl rollout status deployment/web
kubectl get deployment,rs,pods -l app=web
kubectl rollout history deployment/web
```

A successful API update does not mean the application rollout succeeded. Always wait for rollout status and check readiness.

## Rollback

`kubectl rollout undo` switches the Deployment back toward a previous Pod template revision. It does not roll back external database schema changes, cloud resources or other systems automatically, so application rollback planning must be broader than one command.


---

# Module 06 — ReplicaSets, Deployments, Rollouts and Rollbacks: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create deployment

```bash
kubectl create deployment web --image=nginx:1.27
```

**Why:** Use this when you need to create deployment. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Scale

```bash
kubectl scale deployment web --replicas=3
```

**Why:** Use this when you need to scale. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Update image

```bash
kubectl set image deployment/web nginx=nginx:1.28
```

**Why:** Use this when you need to update image. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Watch rollout

```bash
kubectl rollout status deployment/web
```

**Why:** Use this when you need to watch rollout. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### History

```bash
kubectl rollout history deployment/web
```

**Why:** Use this when you need to history. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Rollback

```bash
kubectl rollout undo deployment/web
```

**Why:** Use this when you need to rollback. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 06 — ReplicaSets, Deployments, Rollouts and Rollbacks: Hands-On Lab

## Objective
See ReplicaSet revisions created during a Deployment rollout.

```bash
kubectl create namespace rollout-lab
kubectl create deployment web --image=nginx:1.27 -n rollout-lab
kubectl scale deployment web --replicas=3 -n rollout-lab
kubectl get deploy,rs,pods -n rollout-lab
```

Update:

```bash
kubectl set image deployment/web nginx=nginx:1.28 -n rollout-lab
kubectl rollout status deployment/web -n rollout-lab
kubectl get rs -n rollout-lab
kubectl rollout history deployment/web -n rollout-lab
```

Create a bad rollout:

```bash
kubectl set image deployment/web nginx=nginx:bad-tag -n rollout-lab
kubectl rollout status deployment/web -n rollout-lab --timeout=30s || true
kubectl get pods -n rollout-lab
kubectl describe deployment web -n rollout-lab
```

Rollback:

```bash
kubectl rollout undo deployment/web -n rollout-lab
kubectl rollout status deployment/web -n rollout-lab
kubectl delete namespace rollout-lab
```


---

# Module 07 — Labels, Selectors, Annotations and Namespaces

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Labels are key/value identity metadata used to group and select Kubernetes objects. Selectors connect objects such as Services and Deployments to Pods. Annotations store non-identifying metadata, while Namespaces provide logical scope for names, policies, quotas and RBAC.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- labels for identity
- selectors for grouping
- annotations for metadata
- namespace boundaries
- recommended naming and labeling

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Services and controllers depend heavily on correct selectors.
- Labels should be queryable identity; annotations hold non-identifying metadata.
- Namespaces are logical boundaries, not hard security boundaries by themselves.

## 6. Core Commands

| Task | Command |
|---|---|
| Create namespace | `kubectl create namespace dev` |
| Label namespace | `kubectl label namespace dev environment=dev` |
| List labels | `kubectl get pods --show-labels` |
| Filter by label | `kubectl get pods -l app=web` |
| Add annotation | `kubectl annotate deployment web owner=platform-team` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Service has no endpoints | Check selector matches Pod labels. |
| Deployment selector error | Deployment selector is immutable and must match pod-template labels. |
| Resource seems missing | Check the namespace. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Labels, Selectors, Annotations and Namespaces

## Labels and Selectors Are Relationships

A Service does not know Deployment names. It selects Pods by labels. A Deployment's selector must match labels in its Pod template.

```text
Service selector: app=api
        |
        +--> Pod app=api
        +--> Pod app=api
```

A one-character selector mismatch can create a healthy Service object with zero backends.

## Labels vs Annotations

Use labels for values that will be selected/grouped, such as `app`, `environment`, `component`. Use annotations for metadata consumed by humans/tools when selection is not needed, such as documentation URLs or controller-specific settings.

## Namespaces

Namespaces scope names and many policies. `web` in namespace `dev` is a different object from `web` in `prod`.

Namespaces help organize RBAC, NetworkPolicy, ResourceQuota and lifecycle, but they are not automatically a strong multi-tenant isolation boundary without policies around them.


---

# Module 07 — Labels, Selectors, Annotations and Namespaces: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create namespace

```bash
kubectl create namespace dev
```

**Why:** Use this when you need to create namespace. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Label namespace

```bash
kubectl label namespace dev environment=dev
```

**Why:** Use this when you need to label namespace. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List labels

```bash
kubectl get pods --show-labels
```

**Why:** Use this when you need to list labels. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Filter by label

```bash
kubectl get pods -l app=web
```

**Why:** Use this when you need to filter by label. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Add annotation

```bash
kubectl annotate deployment web owner=platform-team
```

**Why:** Use this when you need to add annotation. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 07 — Labels, Selectors, Annotations and Namespaces: Hands-On Lab

## Objective
Prove how selectors depend on labels.

```bash
kubectl create namespace label-lab
kubectl create deployment web --image=nginx:alpine --replicas=2 -n label-lab
kubectl label deployment web owner=platform -n label-lab
kubectl get deployment web -n label-lab --show-labels
kubectl get pods -n label-lab --show-labels
```

Create a Service with the correct selector:

```bash
kubectl expose deployment web --port=80 --target-port=80 -n label-lab
kubectl get svc,endpointslice -n label-lab
```

Inspect Pod labels, then intentionally edit the Service selector to a non-matching value:

```bash
kubectl edit service web -n label-lab
kubectl get endpointslice -n label-lab -o wide
```

Restore `app=web` and verify endpoints return.

```bash
kubectl annotate deployment web runbook='training-demo' -n label-lab
kubectl delete namespace label-lab
```


---

# Module 08 — Services, DNS and Service Discovery

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

A Service gives a stable virtual endpoint to a changing set of Pods. It selects Ready Pods through labels and represents their backends through EndpointSlices. CoreDNS adds DNS names so workloads can find Services without knowing Pod IP addresses, which change as Pods are recreated.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- ClusterIP, NodePort, LoadBalancer and ExternalName
- Service selectors and EndpointSlices
- CoreDNS naming
- port versus targetPort
- service discovery

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- A Service provides a stable virtual endpoint in front of changing Pods.
- `targetPort` is the application port in the Pod.
- Cluster DNS usually resolves `<service>.<namespace>.svc.cluster.local`.

## 6. Core Commands

| Task | Command |
|---|---|
| List services | `kubectl get svc -A` |
| Inspect endpoints | `kubectl get endpointslices -l kubernetes.io/service-name=<service>` |
| DNS test | `kubectl run dns-test --rm -it --restart=Never --image=busybox:1.36 -- nslookup kubernetes.default.svc.cluster.local` |
| Port forward service | `kubectl port-forward svc/<service> 8080:80` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Connection refused | Check container is listening on targetPort. |
| No endpoints | Selector does not match Ready Pods. |
| DNS failure | Check CoreDNS pods, service and network connectivity. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Services, DNS and Service Discovery

## Why Pod IP Is Not a Stable Application Endpoint

Pods are recreated during scaling, rollout and recovery, so their IPs change. A Service gives consumers a stable DNS name and virtual IP while the actual backend set changes.

## Service Types

- `ClusterIP`: cluster-internal stable endpoint; default.
- `NodePort`: opens a high port on nodes and forwards to the Service.
- `LoadBalancer`: asks supported infrastructure/controller integration for an external load balancer.
- `ExternalName`: DNS CNAME-style mapping to an external name.

## port vs targetPort

```text
Client -> Service port 80 -> Pod targetPort 5000
```

If the app listens on 5000 but targetPort says 8080, the Service object can look correct while traffic fails.

## EndpointSlices

EndpointSlices represent actual backend endpoints selected for a Service. When debugging a Service, check them early:

```bash
kubectl get endpointslices -l kubernetes.io/service-name=<svc> -o yaml
```

No endpoints usually means selector/readiness issues, not DNS.

## DNS

Within the cluster, a Service commonly resolves as:

```text
service-name.namespace.svc.cluster.local
```

Short names work according to the caller Pod's DNS search domains.


---

# Module 08 — Services, DNS and Service Discovery: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List services

```bash
kubectl get svc -A
```

**Why:** Use this when you need to list services. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect endpoints

```bash
kubectl get endpointslices -l kubernetes.io/service-name=<service>
```

**Why:** Use this when you need to inspect endpoints. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### DNS test

```bash
kubectl run dns-test --rm -it --restart=Never --image=busybox:1.36 -- nslookup kubernetes.default.svc.cluster.local
```

**Why:** Use this when you need to dns test. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Port forward service

```bash
kubectl port-forward svc/<service> 8080:80
```

**Why:** Use this when you need to port forward service. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 08 — Services, DNS and Service Discovery: Hands-On Lab

## Objective
Trace traffic from DNS name to Service to EndpointSlice to Pods.

```bash
kubectl create namespace svc-lab
kubectl create deployment api --image=nginx:alpine --replicas=2 -n svc-lab
kubectl expose deployment api --name=api --port=80 --target-port=80 -n svc-lab
kubectl get pod,svc,endpointslice -n svc-lab -o wide
```

DNS and HTTP test from inside cluster:

```bash
kubectl run client --rm -it --restart=Never --image=busybox:1.36 -n svc-lab -- nslookup api.svc-lab.svc.cluster.local
kubectl run curl --rm -it --restart=Never --image=curlimages/curl -n svc-lab -- curl -sS http://api
```

Break the Service by changing its selector:

```bash
kubectl patch service api -n svc-lab -p '{"spec":{"selector":{"app":"wrong"}}}'
kubectl get endpointslice -n svc-lab
```

Explain why DNS can still resolve while the Service has no working backend. Restore selector:

```bash
kubectl patch service api -n svc-lab -p '{"spec":{"selector":{"app":"api"}}}'
kubectl delete namespace svc-lab
```


---

# Module 09 — ConfigMaps and Secrets

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

ConfigMaps and Secrets separate runtime configuration from container images. A ConfigMap is for non-sensitive configuration; a Secret is the Kubernetes object for sensitive values, although its data is not automatically protected merely because it is base64-encoded. Applications consume them as environment variables, command arguments or mounted files.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- externalizing configuration
- environment variables versus mounted files
- Secret encoding versus encryption
- immutable configuration patterns
- safe secret handling

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- ConfigMaps hold non-secret configuration.
- Kubernetes Secret data is base64-encoded, not automatically safe in Git.
- Production secrets should integrate with a secure secret-management solution.

## 6. Core Commands

| Task | Command |
|---|---|
| Create ConfigMap | `kubectl create configmap app-config --from-literal=APP_ENV=dev` |
| Create generic Secret | `kubectl create secret generic db-secret --from-literal=username=appuser --from-literal=password=change-me` |
| Inspect ConfigMap | `kubectl get configmap app-config -o yaml` |
| Decode secret value | `kubectl get secret db-secret -o jsonpath='{.data.username}' | base64 -d; echo` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Env change not visible | Environment variables are read at container start; restart/rollout may be needed. |
| Volume config not updated instantly | Projected volume updates are eventually refreshed; application must reread files. |
| Secret leaked to Git | Rotate it immediately and remove it from history. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — ConfigMaps and Secrets

## Configuration Should Not Require a New Image

The same application image should be reusable across dev/QA/prod, while configuration differs by environment. ConfigMaps and Secrets help keep those values outside the image.

## Environment Variable vs Volume

Environment variables are simple, but a running process does not automatically see changes made later. Mounted configuration files can be refreshed by Kubernetes, but the application must reread them.

## Secret Reality

This is reversible encoding:

```bash
printf 'password' | base64
```

Therefore base64 is not encryption. Protect Secrets through RBAC, etcd encryption controls appropriate to the platform, secure Git practices and an external secret-management strategy when required.

## Operational Pattern

A configuration change can be coupled with a rollout using checksum annotations or deployment automation so Pods restart predictably when consumed config changes.


---

# Module 09 — ConfigMaps and Secrets: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create ConfigMap

```bash
kubectl create configmap app-config --from-literal=APP_ENV=dev
```

**Why:** Use this when you need to create configmap. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create generic Secret

```bash
kubectl create secret generic db-secret --from-literal=username=appuser --from-literal=password=change-me
```

**Why:** Use this when you need to create generic secret. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect ConfigMap

```bash
kubectl get configmap app-config -o yaml
```

**Why:** Use this when you need to inspect configmap. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Decode secret value

```bash
kubectl get secret db-secret -o jsonpath='{.data.username}' | base64 -d; echo
```

**Why:** Use this when you need to decode secret value. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 09 — ConfigMaps and Secrets: Hands-On Lab

## Objective
Inject configuration and Secret data without baking it into an image.

```bash
kubectl create namespace config-lab
kubectl create configmap app-config --from-literal=APP_ENV=training -n config-lab
kubectl create secret generic app-secret --from-literal=API_TOKEN='training-token' -n config-lab
```

Create a Pod that reads both objects:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: env-demo
  namespace: config-lab
spec:
  restartPolicy: Never
  containers:
    - name: demo
      image: busybox:1.36
      command: ["sh","-c","env | sort; sleep 3600"]
      envFrom:
        - configMapRef:
            name: app-config
        - secretRef:
            name: app-secret
EOF

kubectl wait --for=condition=Ready pod/env-demo -n config-lab --timeout=120s
```

Then:

```bash
kubectl exec -n config-lab env-demo -- env | sort
kubectl get secret app-secret -n config-lab -o jsonpath='{.data.API_TOKEN}' | base64 -d; echo
```

Explain why base64 is not encryption.

```bash
kubectl delete namespace config-lab
```


---

# Module 10 — Probes, Resources and QoS

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Health probes tell Kubernetes whether a container has started, is ready for traffic or should be restarted. Resource requests and limits tell the scheduler how much capacity a workload needs and constrain resource use. Together they strongly influence stability, placement, autoscaling and failure behavior.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- startup, readiness and liveness probes
- CPU/memory requests and limits
- QoS classes
- OOMKilled
- resource-aware scheduling

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Readiness controls traffic; liveness decides when to restart; startup protects slow starts.
- Requests influence scheduling. Limits enforce maximum use.
- Bad probes can cause outages even when the application itself is healthy.

## 6. Core Commands

| Task | Command |
|---|---|
| View resource requests | `kubectl get pod <pod> -o jsonpath='{.spec.containers[*].resources}'` |
| Top pods | `kubectl top pods -A` |
| Describe pod conditions | `kubectl describe pod <pod>` |
| Show restart counts | `kubectl get pods -o custom-columns=NAME:.metadata.name,RESTARTS:.status.containerStatuses[*].restartCount` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| OOMKilled | Increase memory limit only after understanding real usage/leak. |
| Readiness failing | Check path, port, dependency assumptions and timeout. |
| HPA shows unknown | Metrics Server or resource requests may be missing. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Probes, Resources and QoS

## Three Probe Questions

```text
startupProbe:  Has the application finished starting?
readinessProbe:Should this Pod receive traffic now?
livenessProbe: Is this container unhealthy enough to restart?
```

Do not use liveness as a dependency check that will restart every Pod when an external database is briefly unavailable. That can turn a dependency incident into a full application restart storm.

## Requests and Limits

The scheduler uses requests to decide whether a node has enough allocatable capacity. CPU limit throttles CPU; memory limit can lead to OOM termination if exceeded.

Example:

```yaml
resources:
  requests:
    cpu: 200m
    memory: 256Mi
  limits:
    cpu: 1
    memory: 512Mi
```

`200m` CPU means 0.2 CPU core.

## QoS

Kubernetes derives QoS class from requests/limits. Under node pressure, QoS contributes to eviction behavior. Do not treat it as a substitute for correct capacity planning.


---

# Module 10 — Probes, Resources and QoS: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### View resource requests

```bash
kubectl get pod <pod> -o jsonpath='{.spec.containers[*].resources}'
```

**Why:** Use this when you need to view resource requests. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Top pods

```bash
kubectl top pods -A
```

**Why:** Use this when you need to top pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe pod conditions

```bash
kubectl describe pod <pod>
```

**Why:** Use this when you need to describe pod conditions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Show restart counts

```bash
kubectl get pods -o custom-columns=NAME:.metadata.name,RESTARTS:.status.containerStatuses[*].restartCount
```

**Why:** Use this when you need to show restart counts. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 10 — Probes, Resources and QoS: Hands-On Lab

## Objective
Observe readiness, requests/limits and a probe failure.

```bash
kubectl create namespace health-lab
kubectl apply -n health-lab -f examples/probes-resources.yaml
kubectl get pod health-demo -n health-lab -w
kubectl describe pod health-demo -n health-lab
kubectl get pod health-demo -n health-lab -o jsonpath='{.status.qosClass}'; echo
```

If Metrics Server exists:

```bash
kubectl top pod health-demo -n health-lab
```

Break readiness:

```bash
kubectl patch pod health-demo -n health-lab --type='json' \
  -p='[{"op":"replace","path":"/spec/containers/0/readinessProbe/httpGet/path","value":"/does-not-exist"}]' || true
```

Because many Pod spec fields are immutable, the patch may be rejected. Explain why production probe changes are normally done through the owning Deployment and Pod recreation.

```bash
kubectl delete namespace health-lab
```


---

# Module 11 — Storage: Volumes, PV, PVC and StorageClass

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes separates a workload's request for persistent storage (PVC) from the underlying volume (PV) and from the provisioning policy (StorageClass). CSI drivers connect these Kubernetes storage objects to actual storage systems such as Amazon EBS.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- ephemeral versus persistent storage
- PV and PVC binding
- StorageClass and dynamic provisioning
- access modes
- reclaim policy and expansion

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- PVC is a workload request for storage.
- StorageClass defines how dynamic volumes are provisioned.
- Cloud CSI drivers connect Kubernetes storage objects to provider volumes.

## 6. Core Commands

| Task | Command |
|---|---|
| List storage classes | `kubectl get storageclass` |
| List PVCs | `kubectl get pvc -A` |
| List PVs | `kubectl get pv` |
| Describe PVC | `kubectl describe pvc <pvc-name>` |
| Inspect mounted volumes | `kubectl describe pod <pod-name>` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| PVC Pending | No matching PV/StorageClass, topology issue, or CSI driver problem. |
| Multi-Attach error | Block volume is already attached where access mode does not allow another attachment. |
| Data disappeared | You may have used `emptyDir` or deleted a PVC/PV with Delete reclaim behavior. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

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


---

# Module 11 — Storage: Volumes, PV, PVC and StorageClass: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List storage classes

```bash
kubectl get storageclass
```

**Why:** Use this when you need to list storage classes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List PVCs

```bash
kubectl get pvc -A
```

**Why:** Use this when you need to list pvcs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List PVs

```bash
kubectl get pv
```

**Why:** Use this when you need to list pvs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe PVC

```bash
kubectl describe pvc <pvc-name>
```

**Why:** Use this when you need to describe pvc. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect mounted volumes

```bash
kubectl describe pod <pod-name>
```

**Why:** Use this when you need to inspect mounted volumes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 11 — Storage: Volumes, PV, PVC and StorageClass: Hands-On Lab

## Objective
Inspect dynamic storage behavior. This lab requires a default StorageClass; otherwise use it as a diagnostic exercise.

```bash
kubectl create namespace storage-lab
kubectl get storageclass
kubectl apply -n storage-lab -f examples/pvc.yaml
kubectl get pvc -n storage-lab -w
kubectl describe pvc demo-data -n storage-lab
```

If PVC becomes Bound:

```bash
kubectl get pv
```

Create a Pod that mounts the claim:

```bash
cat <<'EOF' | kubectl apply -n storage-lab -f -

apiVersion: v1
kind: Pod
metadata:
  name: writer
spec:
  containers:
  - name: writer
    image: busybox:1.36
    command: ["sh","-c","echo persistent-data > /data/test.txt; sleep 3600"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: demo-data
EOF
```

Verify the file:

```bash
kubectl wait --for=condition=Ready pod/writer -n storage-lab --timeout=120s
kubectl exec -n storage-lab writer -- cat /data/test.txt
```

Delete and recreate the Pod with the same PVC, then prove the data still exists:

```bash
kubectl delete pod writer -n storage-lab
cat <<'EOF' | kubectl apply -n storage-lab -f -
apiVersion: v1
kind: Pod
metadata:
  name: reader
spec:
  containers:
  - name: reader
    image: busybox:1.36
    command: ["sh","-c","cat /data/test.txt; sleep 3600"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: demo-data
EOF
kubectl wait --for=condition=Ready pod/reader -n storage-lab --timeout=120s
kubectl exec -n storage-lab reader -- cat /data/test.txt
```

This demonstrates that the data lifetime is tied to the persistent volume, not the Pod.

```bash
kubectl delete namespace storage-lab
```


---

# Module 12 — StatefulSet, DaemonSet, Job and CronJob

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Different workloads require different controllers. StatefulSet provides stable identity and per-replica storage patterns, DaemonSet places a Pod on selected nodes, Job runs finite work to completion, and CronJob creates Jobs on a schedule. Choosing the correct controller is an architecture decision.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- when Deployment is not enough
- stable identity with StatefulSet
- one Pod per node with DaemonSet
- finite work with Job
- scheduled work with CronJob

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Choose controller based on workload behavior, not preference.
- StatefulSets provide stable ordinal identity and ordered lifecycle.
- DaemonSets are common for node agents such as logging and monitoring.

## 6. Core Commands

| Task | Command |
|---|---|
| List controller types | `kubectl get deploy,sts,ds,job,cronjob -A` |
| Create job from command | `kubectl create job hello --image=busybox:1.36 -- echo hello` |
| Create cronjob | `kubectl create cronjob heartbeat --image=busybox:1.36 --schedule="*/5 * * * *" -- echo heartbeat` |
| Job logs | `kubectl logs job/hello` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Stateful pod Pending | Check PVC and scheduling constraints. |
| CronJob not running | Check schedule, suspension, controller events and time assumptions. |
| Job retries forever | Set backoffLimit and inspect the failing command. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Workload Controllers

## Deployment
Use when replicas are interchangeable and identity does not matter.

## StatefulSet

Pods receive stable ordinal names such as `db-0`, `db-1`. With `volumeClaimTemplates`, each replica can receive its own PVC. StatefulSet does not make an application database-safe automatically; the application still needs correct replication/consistency design.

## DaemonSet

Ensures a matching Pod is present on selected nodes. Typical examples: log agents, monitoring agents, node networking components.

## Job

Runs Pods until a completion goal is met. Important fields include retry/backoff behavior and parallelism/completions.

## CronJob

Creates Jobs from a cron schedule. Think about concurrency policy, missed schedules, job history and timezone expectations.

Choose a controller by asking: **Is this workload long-running? stateful? node-local? finite? scheduled?**


---

# Module 12 — StatefulSet, DaemonSet, Job and CronJob: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List controller types

```bash
kubectl get deploy,sts,ds,job,cronjob -A
```

**Why:** Use this when you need to list controller types. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create job from command

```bash
kubectl create job hello --image=busybox:1.36 -- echo hello
```

**Why:** Use this when you need to create job from command. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create cronjob

```bash
kubectl create cronjob heartbeat --image=busybox:1.36 --schedule="*/5 * * * *" -- echo heartbeat
```

**Why:** Use this when you need to create cronjob. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Job logs

```bash
kubectl logs job/hello
```

**Why:** Use this when you need to job logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 12 — StatefulSet, DaemonSet, Job and CronJob: Hands-On Lab

## Objective
Compare controller behavior rather than treating every workload as a Deployment.

```bash
kubectl create namespace controller-lab
kubectl create job hello --image=busybox:1.36 -n controller-lab -- sh -c 'echo job-start; sleep 2; echo job-done'
kubectl get job,pods -n controller-lab
kubectl logs job/hello -n controller-lab
```

CronJob:

```bash
kubectl create cronjob heartbeat --image=busybox:1.36 --schedule='*/2 * * * *' -n controller-lab -- sh -c 'date; echo heartbeat'
kubectl get cronjob -n controller-lab
```

Create a DaemonSet:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-agent
  namespace: controller-lab
spec:
  selector:
    matchLabels: {app: node-agent}
  template:
    metadata:
      labels: {app: node-agent}
    spec:
      containers:
        - name: agent
          image: busybox:1.36
          command: ["sh","-c","while true; do echo node-agent; sleep 60; done"]
EOF
```

Create a headless Service + StatefulSet:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: stateful-demo
  namespace: controller-lab
spec:
  clusterIP: None
  selector: {app: stateful-demo}
  ports:
    - port: 80
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: stateful-demo
  namespace: controller-lab
spec:
  serviceName: stateful-demo
  replicas: 2
  selector:
    matchLabels: {app: stateful-demo}
  template:
    metadata:
      labels: {app: stateful-demo}
    spec:
      containers:
        - name: web
          image: nginx:alpine
          ports:
            - containerPort: 80
EOF
```

Verify:

```bash
kubectl get ds,sts,pods -n controller-lab -o wide
```

For each controller, state what causes new Pods to be created and what identity guarantees exist.

```bash
kubectl delete namespace controller-lab
```


---

# Module 13 — Scheduling, Affinity, Taints and Tolerations

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

The scheduler decides which node should run each unscheduled Pod. It filters unsuitable nodes and scores acceptable ones using resources and constraints. nodeSelector/affinity attract workloads to nodes, taints repel them, tolerations allow exceptions, and topology rules spread replicas for availability.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- scheduler filtering/scoring
- nodeSelector
- node affinity
- pod affinity/anti-affinity
- taints and tolerations
- topology spread

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Labels attract/select; taints repel; tolerations permit scheduling onto tainted nodes.
- Hard affinity rules can make Pods unschedulable.
- Spread constraints improve availability across zones/nodes.

## 6. Core Commands

| Task | Command |
|---|---|
| Show node labels | `kubectl get nodes --show-labels` |
| Add node label | `kubectl label node <node> workload=apps` |
| Taint node | `kubectl taint nodes <node> dedicated=platform:NoSchedule` |
| Remove taint | `kubectl taint nodes <node> dedicated=platform:NoSchedule-` |
| Show pod node assignment | `kubectl get pods -o wide` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| 0/N nodes available | Read scheduler event; it usually names taint, affinity or resource reason. |
| Pod scheduled to unexpected node | Inspect node labels and preferred versus required affinity. |
| Pod evicted | Check pressure conditions and taint effects. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Scheduling

## Scheduler Logic

The scheduler first filters nodes that cannot run a Pod, then scores suitable nodes. Reasons for filtering include insufficient requested CPU/memory, untolerated taints, required affinity, volume topology and other constraints.

## Attraction and Repulsion

```text
nodeSelector / node affinity -> place Pods on matching nodes
pod affinity                 -> place near matching Pods
a nti-affinity                -> separate from matching Pods
taint                         -> repel Pods
toleration                    -> allow Pod onto matching taint
```

A toleration does not force placement; it only removes one rejection reason.

## Availability

For replicas that should survive node/AZ failure, use anti-affinity or topology spread carefully so all replicas do not land on one failure domain.

## First Pending Check

`kubectl describe pod` often includes scheduler messages like `0/3 nodes are available: insufficient cpu` or untolerated taint. Read that evidence before changing random settings.


---

# Module 13 — Scheduling, Affinity, Taints and Tolerations: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show node labels

```bash
kubectl get nodes --show-labels
```

**Why:** Use this when you need to show node labels. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Add node label

```bash
kubectl label node <node> workload=apps
```

**Why:** Use this when you need to add node label. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Taint node

```bash
kubectl taint nodes <node> dedicated=platform:NoSchedule
```

**Why:** Use this when you need to taint node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Remove taint

```bash
kubectl taint nodes <node> dedicated=platform:NoSchedule-
```

**Why:** Use this when you need to remove taint. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Show pod node assignment

```bash
kubectl get pods -o wide
```

**Why:** Use this when you need to show pod node assignment. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 13 — Scheduling, Affinity, Taints and Tolerations: Hands-On Lab

## Objective
Make a Pod Pending through scheduling rules, then fix the rule.

```bash
kubectl get nodes --show-labels
NODE=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
kubectl label node "$NODE" workload=apps
kubectl taint node "$NODE" dedicated=platform:NoSchedule
```

Apply the module scheduling example:

```bash
kubectl apply -f examples/scheduling.yaml
kubectl get pod scheduled-demo -o wide
kubectl describe pod scheduled-demo
```

If the Pod does not schedule, read the scheduler event and determine whether other nodes/constraints affect the result.

Remove lab resources:

```bash
kubectl delete pod scheduled-demo --ignore-not-found
kubectl taint node "$NODE" dedicated=platform:NoSchedule-
kubectl label node "$NODE" workload-
```


---

# Module 14 — ServiceAccounts and RBAC

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes security has two separate questions: who/what are you, and what are you allowed to do? ServiceAccounts provide workload identity inside Kubernetes. RBAC uses Roles/ClusterRoles plus bindings to authorize actions on API resources.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- authentication versus authorization
- ServiceAccounts
- Role and ClusterRole
- RoleBinding and ClusterRoleBinding
- least privilege
- can-i testing

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Role is namespace-scoped; ClusterRole defines cluster-scoped or reusable permissions.
- Binding connects a subject to a role.
- Use least privilege and test with `kubectl auth can-i`.

## 6. Core Commands

| Task | Command |
|---|---|
| Create service account | `kubectl create serviceaccount app-reader -n dev` |
| Test current permissions | `kubectl auth can-i get pods -n dev` |
| Test as service account | `kubectl auth can-i list pods -n dev --as=system:serviceaccount:dev:app-reader` |
| List roles | `kubectl get role,rolebinding -A` |
| List cluster roles | `kubectl get clusterrole,clusterrolebinding` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Forbidden | Find which subject is used, then inspect bindings. |
| ServiceAccount token assumptions | Modern Kubernetes uses projected short-lived tokens by default. |
| Overprivileged role | Reduce verbs/resources and avoid wildcard permissions unless justified. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — ServiceAccounts and RBAC

## Authentication vs Authorization

Authentication answers **who are you?** Authorization answers **may you perform this action?** A `Forbidden` error usually means authentication succeeded but authorization denied the request.

## RBAC Building Blocks

- `Role`: permissions scoped to one namespace.
- `ClusterRole`: cluster-scoped permissions or a reusable permission set.
- `RoleBinding`: binds Role/ClusterRole permissions inside one namespace.
- `ClusterRoleBinding`: grants across the cluster.

## Example Permission

```yaml
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "list", "watch"]
```

This is much safer than `resources: ["*"]`, `verbs: ["*"]`.

## Test Before Handing Access Out

```bash
kubectl auth can-i list pods --as=system:serviceaccount:dev:app-reader -n dev
```

In EKS, AWS IAM/EKS access determines entry to the cluster API, while Kubernetes RBAC can still determine Kubernetes permissions depending on the chosen access model.


---

# Module 14 — ServiceAccounts and RBAC: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create service account

```bash
kubectl create serviceaccount app-reader -n dev
```

**Why:** Use this when you need to create service account. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Test current permissions

```bash
kubectl auth can-i get pods -n dev
```

**Why:** Use this when you need to test current permissions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Test as service account

```bash
kubectl auth can-i list pods -n dev --as=system:serviceaccount:dev:app-reader
```

**Why:** Use this when you need to test as service account. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List roles

```bash
kubectl get role,rolebinding -A
```

**Why:** Use this when you need to list roles. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List cluster roles

```bash
kubectl get clusterrole,clusterrolebinding
```

**Why:** Use this when you need to list cluster roles. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 14 — ServiceAccounts and RBAC: Hands-On Lab

## Objective
Create a namespace-scoped read-only identity and prove allowed/denied actions.

```bash
kubectl create namespace dev --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f examples/rbac-readonly.yaml
```

Test allowed operations:

```bash
kubectl auth can-i get pods -n dev --as=system:serviceaccount:dev:app-reader
kubectl auth can-i list pods -n dev --as=system:serviceaccount:dev:app-reader
```

Test denied operations:

```bash
kubectl auth can-i delete pods -n dev --as=system:serviceaccount:dev:app-reader
kubectl auth can-i create deployments -n dev --as=system:serviceaccount:dev:app-reader
```

Inspect the chain:

```bash
kubectl get sa,role,rolebinding -n dev -o yaml
```

Explain subject → RoleBinding → Role → rules.

```bash
kubectl delete namespace dev
```


---

# Module 15 — Kubernetes Networking and CNI

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes expects Pods to communicate over a cluster network without application-level NAT between Pod endpoints. A CNI implementation allocates/configures Pod networking, CoreDNS provides names, and Service routing is implemented by kube-proxy or an equivalent data plane such as eBPF-based networking.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- Pod networking model
- CNI responsibility
- Pod CIDR and Service CIDR
- kube-proxy/service routing
- CoreDNS
- cross-node traffic

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Every Pod gets an IP in the cluster network model.
- CNI provides Pod networking; kube-proxy or equivalent implements Service routing.
- DNS depends on both CoreDNS health and working Pod networking.

## 6. Core Commands

| Task | Command |
|---|---|
| Pod IPs | `kubectl get pods -A -o wide` |
| Node routes | `ip route` |
| System networking pods | `kubectl get pods -n kube-system -o wide` |
| DNS test | `kubectl run nettest --rm -it --restart=Never --image=busybox:1.36 -- sh` |
| Inspect service endpoints | `kubectl get endpointslices -A` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Pods on same node work but cross-node fail | Check CNI overlay/routing and security groups/firewalls. |
| Service IP fails but Pod IP works | Check Service, EndpointSlice and kube-proxy/eBPF service implementation. |
| DNS fails only | Check CoreDNS and access to kube-dns Service. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Kubernetes Networking and CNI

## Network Model

Each Pod receives an IP. Pods should be able to communicate according to cluster network policy without applications knowing which physical node hosts the peer.

## CNI

CNI plugins create/configure Pod network interfaces, IP allocation and routing/overlay behavior. Examples include Calico and cloud-provider networking implementations.

## Service Routing

Service IPs are virtual. kube-proxy or another dataplane programs rules that send Service traffic toward actual endpoints.

## Troubleshooting Layers

```text
1. Is Pod running and listening?
2. Can caller reach Pod IP?
3. Does Service have EndpointSlices?
4. Can caller reach Service IP/name?
5. Does DNS resolve?
6. Does NetworkPolicy allow flow?
7. Does node/CNI routing work cross-node?
```

Testing each layer prevents mixing an app-port issue with a CNI issue.


---

# Module 15 — Kubernetes Networking and CNI: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Pod IPs

```bash
kubectl get pods -A -o wide
```

**Why:** Use this when you need to pod ips. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Node routes

```bash
ip route
```

**Why:** Use this when you need to node routes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### System networking pods

```bash
kubectl get pods -n kube-system -o wide
```

**Why:** Use this when you need to system networking pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### DNS test

```bash
kubectl run nettest --rm -it --restart=Never --image=busybox:1.36 -- sh
```

**Why:** Use this when you need to dns test. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect service endpoints

```bash
kubectl get endpointslices -A
```

**Why:** Use this when you need to inspect service endpoints. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 15 — Kubernetes Networking and CNI: Hands-On Lab

## Objective
Test Pod-to-Pod, Service and DNS layers separately.

```bash
kubectl create namespace net-lab
kubectl create deployment web --image=nginx:alpine --replicas=2 -n net-lab
kubectl expose deployment web --port=80 -n net-lab
kubectl get pods -n net-lab -o wide
kubectl get svc,endpointslice -n net-lab
```

Start a debug shell:

```bash
kubectl run net-debug --rm -it --restart=Never --image=busybox:1.36 -n net-lab -- sh
```

Inside the Pod:

```sh
ip addr
ip route
nslookup web
wget -qO- http://web
```

Back on a node/self-managed cluster, inspect:

```bash
ip route
ip link show | egrep 'cali|vxlan|cni' || true
```

Explain which test proves DNS, Service routing and Pod network reachability.

```bash
kubectl delete namespace net-lab
```


---

# Module 16 — NetworkPolicy

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

NetworkPolicy is a Kubernetes API for controlling permitted Pod ingress and egress. Policies select Pods and then describe allowed peers and ports. Enforcement is provided by the networking implementation, so a policy object by itself is not useful on a CNI that does not implement NetworkPolicy.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- default allow behavior
- ingress and egress isolation
- podSelector and namespaceSelector
- DNS egress
- CNI enforcement requirements

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- NetworkPolicy only works when the CNI enforces it.
- Start with known flows and introduce default-deny carefully.
- Remember DNS when restricting egress.

## 6. Core Commands

| Task | Command |
|---|---|
| List policies | `kubectl get networkpolicy -A` |
| Describe policy | `kubectl describe networkpolicy <policy> -n <namespace>` |
| Run connectivity test | `kubectl run curl --rm -it --restart=Never --image=curlimages/curl -- curl -m 3 http://<service>` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Policy has no effect | CNI may not support/enforce NetworkPolicy or selector is wrong. |
| Everything broke after default deny | Add explicit DNS and required app dependencies. |
| Namespace selector mismatch | Label namespaces and verify selectors. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

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


---

# Module 16 — NetworkPolicy: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List policies

```bash
kubectl get networkpolicy -A
```

**Why:** Use this when you need to list policies. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe policy

```bash
kubectl describe networkpolicy <policy> -n <namespace>
```

**Why:** Use this when you need to describe policy. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Run connectivity test

```bash
kubectl run curl --rm -it --restart=Never --image=curlimages/curl -- curl -m 3 http://<service>
```

**Why:** Use this when you need to run connectivity test. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 16 — NetworkPolicy: Hands-On Lab

## Objective
Prove both allowed and denied traffic. Requires a CNI that enforces NetworkPolicy.

```bash
kubectl create namespace policy-lab
kubectl create deployment web --image=nginx:alpine -n policy-lab
kubectl expose deployment web --port=80 -n policy-lab
kubectl run client --image=curlimages/curl --command -n policy-lab -- sleep 3600
```

Baseline:

```bash
kubectl exec -n policy-lab client -- curl -sS http://web
```

Apply default-deny ingress:

```bash
kubectl apply -n policy-lab -f examples/default-deny.yaml
kubectl exec -n policy-lab client -- curl -m 3 http://web || echo 'blocked as expected'
```

Label the client and add an allow policy:

```bash
kubectl label pod client role=client -n policy-lab
cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-client-to-web
  namespace: policy-lab
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes: [Ingress]
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: client
      ports:
        - protocol: TCP
          port: 80
EOF

kubectl exec -n policy-lab client -- curl -m 3 http://web
```

If traffic is still allowed after the ingress default deny, determine whether your CNI enforces NetworkPolicy.

Optional egress lesson: add an Egress policy for the client. When you deny egress, remember that the client also needs DNS (TCP/UDP 53) in addition to application traffic; otherwise the Service name cannot resolve.

```bash
kubectl delete namespace policy-lab
```


---

# Module 17 — Ingress, Gateway Concepts and TLS

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Ingress and Gateway-style APIs describe north-south application routing. They are configuration objects, not the proxy itself: a controller must watch them and configure an actual load balancer or proxy. TLS, DNS, host rules and path routing are all part of the complete request path.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- north-south traffic
- Ingress resource versus Ingress Controller
- host/path routing
- TLS Secrets
- Gateway API concepts
- cloud load balancer integration

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- An Ingress object does nothing without a compatible controller.
- TLS termination usually occurs at the ingress/load-balancer layer.
- Gateway API provides a more expressive role-oriented model, but adoption depends on controller support.

## 6. Core Commands

| Task | Command |
|---|---|
| List ingress classes | `kubectl get ingressclass` |
| List ingress | `kubectl get ingress -A` |
| Describe ingress | `kubectl describe ingress <name> -n <namespace>` |
| Create TLS secret | `kubectl create secret tls web-tls --cert=tls.crt --key=tls.key -n web` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Ingress has no address | Controller, class, permissions or cloud integration is missing. |
| 404 from controller | Host/path rule does not match request or backend service. |
| TLS warning | Certificate name/chain/secret or DNS is wrong. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Ingress, Gateway and TLS

## Complete Request Path

```text
DNS -> public/private IP -> Load Balancer/Ingress Controller
    -> Ingress/Gateway rule -> Kubernetes Service -> Ready Pod
```

Troubleshoot from outside inward. If DNS resolves to the wrong load balancer, Kubernetes Pod health is not the first problem.

## Ingress Resource vs Controller

The Ingress YAML contains routing intent. An NGINX Ingress Controller, AWS Load Balancer Controller or another controller watches that intent and creates/configures actual data-plane infrastructure.

## TLS

TLS needs a certificate whose names match the requested hostname, correct certificate chain/key configuration, and traffic reaching the TLS termination point.

## EKS Example

On EKS, the AWS Load Balancer Controller can translate supported Ingress configuration into an ALB. Its IAM permissions and subnet/network discovery are AWS-side dependencies in addition to Kubernetes configuration.


---

# Module 17 — Ingress, Gateway Concepts and TLS: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List ingress classes

```bash
kubectl get ingressclass
```

**Why:** Use this when you need to list ingress classes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List ingress

```bash
kubectl get ingress -A
```

**Why:** Use this when you need to list ingress. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe ingress

```bash
kubectl describe ingress <name> -n <namespace>
```

**Why:** Use this when you need to describe ingress. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create TLS secret

```bash
kubectl create secret tls web-tls --cert=tls.crt --key=tls.key -n web
```

**Why:** Use this when you need to create tls secret. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 17 — Ingress, Gateway Concepts and TLS: Hands-On Lab

## Objective
Understand that an Ingress resource requires a controller.

```bash
kubectl get ingressclass
kubectl get pods -A | grep -Ei 'ingress|load-balancer|gateway' || true
```

Create backend resources:

```bash
kubectl create namespace ingress-lab
kubectl create deployment web --image=nginx:alpine -n ingress-lab
kubectl expose deployment web --port=80 --target-port=80 -n ingress-lab
```

Find the IngressClass:

```bash
kubectl get ingressclass
```

Create `ingress.yaml`, replacing `<INGRESS_CLASS>` with the class installed in your environment:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web
  namespace: ingress-lab
spec:
  ingressClassName: <INGRESS_CLASS>
  rules:
    - host: web.training.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web
                port:
                  number: 80
```

```bash
kubectl apply --dry-run=server -f ingress.yaml
kubectl apply -f ingress.yaml
```

Validate:

```bash
kubectl get ingress -A
kubectl describe ingress <name> -n <namespace>
kubectl get svc,endpointslice -n <namespace>
```

If the Ingress address remains empty, investigate controller installation, IngressClass, events and—in EKS—controller IAM/subnet/network dependencies.

For TLS practice:

```bash
kubectl create secret tls demo-tls --cert=tls.crt --key=tls.key -n <namespace>
```

Explain where TLS terminates in your chosen controller design.

## Cleanup

```bash
kubectl delete namespace ingress-lab
```


---

# Module 18 — Autoscaling, Availability and PDB

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes availability requires both workload replicas and enough infrastructure capacity. HPA changes Pod replica counts from metrics; node-level autoscaling changes compute capacity; PodDisruptionBudget limits voluntary disruption; scheduling/spread rules reduce correlated failure.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- HPA
- metrics requirements
- cluster/node autoscaling concepts
- PodDisruptionBudget
- replica placement
- requests as autoscaling inputs

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- HPA changes Pod replica count based on metrics.
- Node autoscalers add/remove compute capacity when Pods cannot fit or nodes are underused.
- PDB protects availability during voluntary disruptions; it does not prevent all failures.

## 6. Core Commands

| Task | Command |
|---|---|
| List HPA | `kubectl get hpa -A` |
| Describe HPA | `kubectl describe hpa <name>` |
| Watch replicas | `kubectl get deploy,hpa -w` |
| List PDBs | `kubectl get pdb -A` |
| Top pods | `kubectl top pods` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| HPA target unknown | Metrics API unavailable or resource requests missing. |
| Pending pods but nodes do not scale | Check autoscaler logs, node-group limits and scheduling constraints. |
| Drain blocked by PDB | Capacity or PDB settings do not allow the disruption. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

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


---

# Module 18 — Autoscaling, Availability and PDB: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List HPA

```bash
kubectl get hpa -A
```

**Why:** Use this when you need to list hpa. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe HPA

```bash
kubectl describe hpa <name>
```

**Why:** Use this when you need to describe hpa. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Watch replicas

```bash
kubectl get deploy,hpa -w
```

**Why:** Use this when you need to watch replicas. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List PDBs

```bash
kubectl get pdb -A
```

**Why:** Use this when you need to list pdbs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Top pods

```bash
kubectl top pods
```

**Why:** Use this when you need to top pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 18 — Autoscaling, Availability and PDB: Hands-On Lab

## Objective
Use HPA and PDB against a Deployment with resource requests.

```bash
kubectl create namespace scale-lab
kubectl create deployment web --image=nginx:alpine --replicas=2 -n scale-lab
kubectl set resources deployment web -n scale-lab --requests=cpu=50m,memory=64Mi --limits=cpu=200m,memory=128Mi
kubectl autoscale deployment web -n scale-lab --cpu-percent=60 --min=2 --max=6
kubectl get hpa -n scale-lab
```

If Metrics Server is installed:

```bash
kubectl top pods -n scale-lab
kubectl describe hpa web -n scale-lab
```

Create a PDB:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: web-pdb
  namespace: scale-lab
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: web
EOF

kubectl get pdb -n scale-lab
```

Explain why HPA scaling and node scaling solve different problems.

```bash
kubectl delete namespace scale-lab
```


---

# Module 19 — Helm

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Helm is a package manager and templating system for Kubernetes resources. A chart contains templates and defaults, while values customize environments. Helm tracks each installation as a release so teams can inspect, upgrade and roll back groups of Kubernetes objects consistently.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- chart structure
- values and templates
- install/upgrade/rollback
- release history
- lint and template
- environment values

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Helm packages Kubernetes resources into versioned releases.
- Render templates locally before applying sensitive changes.
- Keep environment-specific values separate from reusable chart templates.

## 6. Core Commands

| Task | Command |
|---|---|
| Check Helm | `helm version` |
| Create chart | `helm create student-web` |
| Lint | `helm lint student-web` |
| Render locally | `helm template demo student-web` |
| Install | `helm upgrade --install demo student-web -n demo --create-namespace` |
| History | `helm history demo -n demo` |
| Rollback | `helm rollback demo 1 -n demo` |
| Uninstall | `helm uninstall demo -n demo` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Template error | Use `helm lint` and `helm template --debug`. |
| Upgrade failed | Inspect release status, events and generated manifests. |
| Values ignored | Check nesting/key names and `helm get values`. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Helm

## Chart Structure

Typical chart:

```text
Chart.yaml
values.yaml
templates/
  deployment.yaml
  service.yaml
```

Templates are Go-template-based YAML. Values provide parameters such as image tag, replica count and resource configuration.

## Safe Workflow

```bash
helm lint ./chart
helm template myapp ./chart -f values-dev.yaml > rendered.yaml
kubectl apply --dry-run=server -f rendered.yaml
helm upgrade --install myapp ./chart -f values-dev.yaml
```

Rendering makes it easier to review the actual Kubernetes objects before changing a cluster.

## Release Operations

```bash
helm list -A
helm status myapp -n app
helm get values myapp -n app
helm get manifest myapp -n app
helm history myapp -n app
helm rollback myapp <revision> -n app
```

Helm rollback only covers resources represented in the Helm release; external schema/data migrations still need their own rollback strategy.


---

# Module 19 — Helm: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Check Helm

```bash
helm version
```

**Why:** Use this when you need to check helm. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create chart

```bash
helm create student-web
```

**Why:** Use this when you need to create chart. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Lint

```bash
helm lint student-web
```

**Why:** Use this when you need to lint. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Render locally

```bash
helm template demo student-web
```

**Why:** Use this when you need to render locally. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Install

```bash
helm upgrade --install demo student-web -n demo --create-namespace
```

**Why:** Use this when you need to install. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### History

```bash
helm history demo -n demo
```

**Why:** Use this when you need to history. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Rollback

```bash
helm rollback demo 1 -n demo
```

**Why:** Use this when you need to rollback. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Uninstall

```bash
helm uninstall demo -n demo
```

**Why:** Use this when you need to uninstall. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 19 — Helm: Hands-On Lab

## Objective
Create, render, install, upgrade and roll back a Helm release.

```bash
helm version
mkdir -p /tmp/helm-lab && cd /tmp/helm-lab
helm create student-web
helm lint student-web
helm template student-web student-web > rendered.yaml
```

Inspect rendered Deployment/Service:

```bash
grep -n '^kind:' rendered.yaml
kubectl apply --dry-run=server -f rendered.yaml
```

Install:

```bash
helm upgrade --install student-web student-web -n helm-lab --create-namespace
helm list -n helm-lab
helm status student-web -n helm-lab
helm history student-web -n helm-lab
```

Change `replicaCount` or image tag, upgrade, inspect history, then rollback:

```bash
helm rollback student-web 1 -n helm-lab
helm uninstall student-web -n helm-lab
kubectl delete namespace helm-lab --ignore-not-found
```


---

# Module 20 — Monitoring, Logging and Troubleshooting

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes troubleshooting is evidence-driven. Object status shows current state, events explain many control-plane decisions, container logs show application output, metrics show resource pressure, and node/system logs explain host-level failures. A repeatable investigation order is more reliable than restarting resources randomly.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- golden signals
- metrics, logs and events
- kubectl troubleshooting workflow
- Prometheus/Grafana concepts
- node and control-plane symptoms
- common pod failures

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Troubleshoot from symptoms to evidence: status → events → logs → config → networking/storage.
- Events are often the fastest way to understand Pending and scheduling failures.
- Monitoring is proactive; troubleshooting is reactive investigation.

## 6. Core Commands

| Task | Command |
|---|---|
| Recent events | `kubectl get events -A --sort-by=.lastTimestamp` |
| Pod logs | `kubectl logs <pod> --all-containers=true --tail=200` |
| Previous container logs | `kubectl logs <pod> --previous` |
| Resource metrics | `kubectl top nodes && kubectl top pods -A` |
| Describe failing pod | `kubectl describe pod <pod> -n <namespace>` |
| Debug with ephemeral container | `kubectl debug -it pod/<pod> --image=busybox:1.36 --target=<container>` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| CrashLoopBackOff | Read current and previous logs and verify entrypoint/config/probes. |
| ImagePullBackOff | Inspect event reason and registry credentials. |
| Node NotReady | Check node conditions, kubelet, runtime, disk/memory pressure and CNI. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

# Detailed Notes — Monitoring, Logging and Troubleshooting

## Troubleshooting Order

```text
1. Scope: cluster / namespace / app / one Pod?
2. State: kubectl get
3. Reasons/events: kubectl describe + get events
4. Application output: kubectl logs / --previous
5. Resources: kubectl top, requests/limits, node pressure
6. Connectivity: Pod IP -> Service -> DNS -> policy -> ingress
7. Host/system: kubelet, containerd, CNI, storage driver
```

## Common Status Patterns

- `Pending`: scheduler/storage/resource constraint.
- `ImagePullBackOff`: image/registry authentication or name.
- `CrashLoopBackOff`: process starts and repeatedly exits/fails.
- `OOMKilled`: memory usage crossed enforced boundary.
- `Running` but not Ready: readiness probe is failing.

## Monitoring Layers

- application metrics and SLOs;
- Pod/container metrics;
- node saturation/pressure;
- cluster component/add-on health;
- logs and audit/control-plane events;
- cloud load balancer/storage/network signals in managed platforms.

A dashboard is not the goal; actionable signals and alerts are.


---

# Module 20 — Monitoring, Logging and Troubleshooting: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Recent events

```bash
kubectl get events -A --sort-by=.lastTimestamp
```

**Why:** Use this when you need to recent events. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Pod logs

```bash
kubectl logs <pod> --all-containers=true --tail=200
```

**Why:** Use this when you need to pod logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Previous container logs

```bash
kubectl logs <pod> --previous
```

**Why:** Use this when you need to previous container logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Resource metrics

```bash
kubectl top nodes && kubectl top pods -A
```

**Why:** Use this when you need to resource metrics. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe failing pod

```bash
kubectl describe pod <pod> -n <namespace>
```

**Why:** Use this when you need to describe failing pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Debug with ephemeral container

```bash
kubectl debug -it pod/<pod> --image=busybox:1.36 --target=<container>
```

**Why:** Use this when you need to debug with ephemeral container. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 20 — Monitoring, Logging and Troubleshooting: Hands-On Lab

## Objective
Diagnose three intentionally broken workloads using evidence.

```bash
kubectl create namespace breakfix
kubectl run bad-image --image=nginx:no-such-tag -n breakfix
kubectl run crash --image=busybox:1.36 -n breakfix -- sh -c 'echo starting; exit 1'
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pending
  namespace: breakfix
spec:
  containers:
    - name: web
      image: nginx:alpine
      resources:
        requests:
          cpu: "100000"
EOF
```

For each failure use:

```bash
kubectl get pods -n breakfix -o wide
kubectl describe pod <pod> -n breakfix
kubectl logs <pod> -n breakfix
kubectl logs <pod> -n breakfix --previous
kubectl get events -n breakfix --sort-by=.lastTimestamp
```

Document:

```text
Symptom:
Evidence:
Root cause:
Fix:
Validation command:
```

Also inspect cluster resources:

```bash
kubectl top nodes 2>/dev/null || true
kubectl get nodes
```

```bash
kubectl delete namespace breakfix
```


---

# Module 21 — Kubernetes Security and Day-2 Operations

## 1. Module Goal

By the end of this module, a student should be able to **explain the concept in simple words, run the important commands without guessing, read the related YAML, verify the result, and troubleshoot the most common failures**.

## 2. What / Why / Where

### What is this topic?

Kubernetes production security combines least-privilege identity, secure Pod configuration, network controls, secret protection, trusted images and disciplined operations. Day-2 work also includes draining nodes, patching, backups, version upgrades, deprecation management and recovery testing.

### Why do DevOps engineers need it?

Kubernetes is operated through APIs and controllers. A DevOps engineer must understand not only which YAML to apply, but also **which component reacts to it, what state Kubernetes is trying to create, and which evidence proves that it worked**. This module focuses on those operational connections.

### Where is it used?

- Developer and QA Kubernetes environments.
- Self-managed kubeadm clusters.
- Managed services such as Amazon EKS.
- CI/CD deployment pipelines.
- Production incident investigation and change management.

## 3. Concepts Covered

- Pod Security Standards
- securityContext
- RBAC review
- image and supply-chain hygiene
- Secrets and encryption
- upgrades and backups
- drain/cordon workflows

## 4. Mental Model

```text
User / CI Pipeline
      |
      | kubectl / API request
      v
Kubernetes API Server
      |
      | desired state stored and watched
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster resources
      |
      +--> verify with get / describe / logs / events
```

The exact components involved differ by topic, but this flow is the basis for understanding Kubernetes operations.

## 5. Key Points to Teach

- Run as non-root where possible and drop unnecessary capabilities.
- Upgrade one minor version at a time and validate workloads/add-ons.
- For self-managed control planes, etcd backup is part of disaster recovery.

## 6. Core Commands

| Task | Command |
|---|---|
| Show security context | `kubectl get pod <pod> -o jsonpath='{.spec.securityContext}'` |
| Cordon node | `kubectl cordon <node>` |
| Drain node | `kubectl drain <node> --ignore-daemonsets --delete-emptydir-data` |
| Uncordon node | `kubectl uncordon <node>` |
| Check API deprecations | `kubectl api-resources` |
| Review permissions | `kubectl auth can-i --list` |

Read `COMMANDS.md` in this module for the extended command sheet and explanations.

## 7. Command Workflow — Do Not Skip Verification

Use this workflow during demos:

```bash
# 1. Confirm the target cluster and namespace
kubectl config current-context
kubectl config view --minify

# 2. Inspect existing state
kubectl get all -A

# 3. Apply or run the module action
# command depends on the topic

# 4. Verify object state
kubectl get <resource> -o wide

# 5. Inspect details and events
kubectl describe <resource> <name>
kubectl get events --sort-by=.lastTimestamp

# 6. Read application logs when relevant
kubectl logs <pod-name>
```

## 8. YAML Reading Method

Whenever you open a YAML file, read it in this order:

```yaml
apiVersion: ...   # Which Kubernetes API group/version?
kind: ...         # What object are we creating?
metadata:         # What is it called? Which namespace? Which labels?
spec:             # What state do we want?
```

Then ask:

1. Which controller/component will act on this `spec`?
2. Which labels/selectors connect this object to another object?
3. Which ports, volumes, identities or policies are being referenced?
4. What command proves it is working?

## 9. Common Problems

| Symptom | What to check first |
|---|---|
| Drain will not complete | Check PDBs, unmanaged Pods and local storage. |
| Upgrade breaks workload | Check removed/deprecated APIs and add-on compatibility before upgrade. |
| Privileged workload rejected | Pod Security admission or policy engine is enforcing controls. |

## 10. Detailed Topic Notes

Read `DETAILED-NOTES.md` for the module-specific deep explanation and teaching narrative.

## 11. Hands-On Lab

Open `LAB.md`. Complete the lab without copying the answer blindly. After each step, run the validation command and explain the result.

## 12. Production Notes

- Do not use `latest` image tags for controlled production releases.
- Store manifests/charts in Git and review changes through pull requests.
- Use namespaces, RBAC and policy boundaries appropriate to the organization.
- Add resource requests, probes and monitoring before calling a workload production-ready.
- Prefer short-lived cloud credentials and workload identity mechanisms.

## 13. Interview Check

Be able to answer these without reading notes:

1. Explain this topic in one minute.
2. Which Kubernetes component is primarily involved?
3. Which command would you run first when it fails?
4. What is the most common misconfiguration?
5. How would your approach differ in Amazon EKS versus self-managed Kubernetes?

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.


---

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


---

# Module 21 — Kubernetes Security and Day-2 Operations: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show security context

```bash
kubectl get pod <pod> -o jsonpath='{.spec.securityContext}'
```

**Why:** Use this when you need to show security context. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Cordon node

```bash
kubectl cordon <node>
```

**Why:** Use this when you need to cordon node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Drain node

```bash
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data
```

**Why:** Use this when you need to drain node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Uncordon node

```bash
kubectl uncordon <node>
```

**Why:** Use this when you need to uncordon node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Check API deprecations

```bash
kubectl api-resources
```

**Why:** Use this when you need to check api deprecations. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Review permissions

```bash
kubectl auth can-i --list
```

**Why:** Use this when you need to review permissions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```


---

# Module 21 — Kubernetes Security and Day-2 Operations: Hands-On Lab

## Objective
Validate secure Pod settings and practice the node-maintenance decision flow.

```bash
kubectl apply -f examples/secure-pod.yaml
kubectl get pod secure-demo
kubectl get pod secure-demo -o yaml | grep -A20 -E 'securityContext|seccomp|capabilities'
```

Verify container user when tools permit:

```bash
kubectl exec secure-demo -- id
```

RBAC review:

```bash
kubectl auth can-i --list
kubectl get clusterrolebinding
```

Node maintenance practice—**do not drain a production node as a classroom test**. On a disposable lab node:

```bash
kubectl cordon <lab-node>
kubectl get nodes
kubectl drain <lab-node> --ignore-daemonsets --delete-emptydir-data
kubectl get pods -A -o wide
kubectl uncordon <lab-node>
```

Explain how PDB, DaemonSets and unmanaged Pods affect drain behavior.

```bash
kubectl delete pod secure-demo --ignore-not-found
```


---

# Self-Managed kubeadm Cluster Track


---

# 1. Architecture and EC2 Servers

## Recommended Lab Size

| Server | Purpose | OS | Suggested type | Disk |
|---|---|---|---|---|
| `k8s-cp-01` | Control plane | Ubuntu 24.04 LTS | t3.medium | 20 GiB gp3 |
| `k8s-worker-01` | Worker | Ubuntu 24.04 LTS | t3.medium | 20 GiB gp3 |
| `k8s-worker-02` | Worker | Ubuntu 24.04 LTS | t3.medium | 20 GiB gp3 |

For a learning cluster, place the three instances in the same VPC and preferably the same private network path so node-to-node communication is straightforward.

## Hostnames

On each instance set the intended hostname:

```bash
# control plane
sudo hostnamectl set-hostname k8s-cp-01

# worker 1
sudo hostnamectl set-hostname k8s-worker-01

# worker 2
sudo hostnamectl set-hostname k8s-worker-02
```

Verify:

```bash
hostname
hostname -I
ip addr
ip route
```

## Capture Private IPs

Create a small note before continuing:

```text
CONTROL_PLANE_IP=<private-ip>
WORKER_1_IP=<private-ip>
WORKER_2_IP=<private-ip>
```

Kubernetes node communication should use the stable internal/private network path, not random public addresses.


---

# 2. Network and Security Groups

For a training cluster, the simplest safe model is:

- One cluster Security Group attached to all three nodes.
- Allow **all traffic from the same Security Group to itself** so control-plane, kubelet and CNI traffic can flow between nodes.
- Allow SSH TCP/22 only from your admin public IP `/32` if SSH is required.
- Allow Kubernetes API TCP/6443 only from your trusted admin source if you plan to use kubectl directly against the public path.
- Do not expose etcd ports to the internet.

## Kubernetes Ports to Understand

### Control plane

| Port | Purpose |
|---|---|
| TCP 6443 | Kubernetes API server |
| TCP 2379-2380 | etcd client/peer |
| TCP 10250 | kubelet API |
| TCP 10257 | controller-manager secure port |
| TCP 10259 | scheduler secure port |

### Worker

| Port | Purpose |
|---|---|
| TCP 10250 | kubelet API |
| TCP 30000-32767 | default NodePort range when NodePort is used |

CNI networking can require additional protocol/port allowances. A self-referencing cluster SG avoids having to open every internal CNI port individually in a learning environment.

## Linux Connectivity Tests

From each node:

```bash
ping -c 3 <other-node-private-ip>
nc -vz <control-plane-private-ip> 6443
```

Before kubeadm init, TCP/6443 will not yet be listening; after initialization it should be reachable.


---

# 3. Prepare Ubuntu on All Nodes

Run these steps on **control plane and every worker**.

## Update OS

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

## Disable Swap

Kubernetes expects swap configuration to be intentional. For this training cluster, disable it:

```bash
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
free -h
swapon --show
```

`swapon --show` should return no active swap.

## Load Kernel Modules

```bash
cat <<'EOF' | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
```

Verify:

```bash
lsmod | egrep 'overlay|br_netfilter'
```

## Required sysctl Settings

```bash
cat <<'EOF' | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
```

Verify:

```bash
sysctl net.ipv4.ip_forward
sysctl net.bridge.bridge-nf-call-iptables
```

Expected important value: `net.ipv4.ip_forward = 1`.


---

# 4. Install and Configure containerd on All Nodes

## Install

```bash
sudo apt-get update
sudo apt-get install -y containerd
```

## Create Default Configuration

```bash
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
```

## Use systemd cgroups

Kubelet and the container runtime should use compatible cgroup management.

```bash
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
```

Verify the setting:

```bash
grep -n 'SystemdCgroup' /etc/containerd/config.toml
```

## Restart and Enable

```bash
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd --no-pager
```

## Useful Runtime Checks

```bash
containerd --version
sudo crictl info
```

If `crictl` reports endpoint warnings before kubeadm packages are fully configured, continue with the next step and validate the runtime again afterward.


---

# 5. Install kubeadm, kubelet and kubectl on All Nodes

This lab uses the Kubernetes **v1.36** package repository.

## Add Repository Key

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

## Add Kubernetes Repository

```bash
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

## Install Packages

```bash
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
```

The kubelet may restart/fail until kubeadm gives it cluster configuration. That is expected before `kubeadm init` or `kubeadm join`.

## Verify Versions

```bash
kubeadm version
kubelet --version
kubectl version --client
apt-mark showhold
```


---

# 6. Initialize the Control Plane

Run only on `k8s-cp-01`.

## Preflight

```bash
sudo systemctl is-active containerd
sudo systemctl status kubelet --no-pager
ip addr
```

## Initialize

Replace `<CONTROL_PLANE_PRIVATE_IP>` with the private IP of `k8s-cp-01`.

```bash
sudo kubeadm init \
  --apiserver-advertise-address=<CONTROL_PLANE_PRIVATE_IP> \
  --pod-network-cidr=192.168.0.0/16
```

**Save the `kubeadm join ...` command printed at the end.** It contains a short-lived bootstrap token and CA hash used by workers.

## Configure kubectl for ubuntu User

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Inspect Initial State

```bash
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -n kube-system -o wide
```

The control-plane node will normally remain `NotReady` until a CNI plugin is installed.

## Generate a New Join Command Later

```bash
kubeadm token create --print-join-command
```


---

# 7. Install Calico CNI

Run on the control-plane node after kubeadm initialization.

This course uses the Calico operator installation and the `192.168.0.0/16` Pod network used during `kubeadm init`.

## Install CRDs and Operator

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/v1_crd_projectcalico_org.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/tigera-operator.yaml
```

## Download Custom Resources

```bash
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/custom-resources.yaml
```

Inspect before applying:

```bash
grep -n -A5 -B5 'cidr:' custom-resources.yaml
```

Ensure the configured IP pool matches the intended Pod CIDR for your lab, then create it:

```bash
kubectl create -f custom-resources.yaml
```

## Watch CNI Readiness

```bash
kubectl get pods -A -w
```

In another terminal:

```bash
kubectl get tigerastatus
kubectl get nodes -o wide
```

Do not continue until the control-plane node becomes `Ready` and Calico components are healthy.


---

# 8. Join Worker Nodes

Run the join command on **each worker**.

Example shape:

```bash
sudo kubeadm join <CONTROL_PLANE_PRIVATE_IP>:6443 \
  --token <TOKEN> \
  --discovery-token-ca-cert-hash sha256:<HASH>
```

If the original token expired, generate a fresh command on the control plane:

```bash
kubeadm token create --print-join-command
```

## Verify from Control Plane

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
```

Expected topology:

```text
k8s-cp-01       Ready    control-plane
k8s-worker-01   Ready    <none>
k8s-worker-02   Ready    <none>
```

## Check kubelet on a Worker if Join Fails

```bash
sudo systemctl status kubelet --no-pager
sudo journalctl -u kubelet -n 100 --no-pager
sudo systemctl status containerd --no-pager
```


---

# 9. Validate the kubeadm Cluster

## Cluster Health

```bash
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp | tail -30
```

## API Ready Check

```bash
kubectl get --raw='/readyz?verbose'
```

## Cross-Node Pod Test

```bash
kubectl create deployment web-test --image=nginx:alpine --replicas=3
kubectl get pods -o wide
kubectl expose deployment web-test --port=80 --target-port=80 --type=ClusterIP
kubectl get svc web-test
```

Run a disposable client:

```bash
kubectl run curl-test --rm -it --restart=Never --image=curlimages/curl -- \
  curl -sS http://web-test
```

If you receive the Nginx HTML response, Pod networking + Service discovery are functioning.

Cleanup:

```bash
kubectl delete deployment web-test
kubectl delete service web-test
```


---

# 10. Use kubectl from Your Admin Workstation

Do **not** copy `admin.conf` into public/shared locations. Treat it as a cluster-admin credential.

For a lab, you can securely copy the kubeconfig from the control plane to your workstation, then update the server endpoint so it is reachable from your workstation.

Example copy:

```bash
scp -i <key.pem> ubuntu@<control-plane-host>:/home/ubuntu/.kube/config ./kubeadm-lab-config
```

Use it temporarily:

```bash
export KUBECONFIG=$PWD/kubeadm-lab-config
kubectl config current-context
kubectl get nodes
```

For real environments, create separate user identities/certificates and RBAC rather than distributing the cluster-admin kubeconfig.


---

# 11. kubeadm Troubleshooting

## Node NotReady

```bash
kubectl describe node <node>
sudo systemctl status kubelet --no-pager
sudo journalctl -u kubelet -n 200 --no-pager
sudo systemctl status containerd --no-pager
```

Look for CNI, runtime, certificate, disk/memory pressure or network problems.

## kubeadm init Preflight Errors

```bash
sudo kubeadm reset -f
sudo systemctl restart containerd
sudo systemctl restart kubelet
```

Do not use `--ignore-preflight-errors=all` as the normal fix. Understand the failed preflight check.

## API Server Not Reachable

On control plane:

```bash
sudo ss -lntp | grep 6443
sudo crictl ps -a | grep kube-apiserver
sudo crictl logs <api-server-container-id>
```

From another node:

```bash
nc -vz <control-plane-private-ip> 6443
```

## Pods Pending After CNI Install

```bash
kubectl get pods -A -o wide
kubectl get tigerastatus
kubectl get events -A --sort-by=.lastTimestamp
```

## CoreDNS Pending

CoreDNS often remains Pending/NotReady when the cluster network is not ready. Fix CNI/node readiness first instead of restarting CoreDNS repeatedly.


---

# 12. Reset and Cleanup

Run on workers first, then control plane when destroying the lab.

```bash
sudo kubeadm reset -f
sudo systemctl stop kubelet
sudo rm -rf /etc/cni/net.d
sudo rm -rf $HOME/.kube
```

Optional network cleanup if a broken lab leaves CNI interfaces behind:

```bash
ip link show
sudo ip link delete cni0 2>/dev/null || true
sudo ip link delete flannel.1 2>/dev/null || true
```

Then terminate the EC2 instances and remove lab Security Groups/VPC resources if they are no longer required.

## Do not forget AWS cost cleanup

```bash
aws ec2 describe-instances \
  --filters 'Name=instance-state-name,Values=running' \
  --query 'Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,Type:InstanceType}' \
  --output table
```


---

# kubeadm EC2 Track — Command Runbook

This file is the copy/paste command index. Read the numbered documents before using it.

## All Nodes

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

cat <<'EOF' | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<'EOF' | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
```

## Control Plane

```bash
sudo kubeadm init --apiserver-advertise-address=<CONTROL_PLANE_PRIVATE_IP> --pod-network-cidr=192.168.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/v1_crd_projectcalico_org.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/tigera-operator.yaml
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.32.1/manifests/custom-resources.yaml
kubectl create -f custom-resources.yaml
```

## Workers

```bash
sudo kubeadm join <CONTROL_PLANE_PRIVATE_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>
```

## Validation

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get --raw='/readyz?verbose'
kubectl get events -A --sort-by=.lastTimestamp
```


---

# Self-Managed Kubernetes with kubeadm on EC2 — On-Prem Style

This track teaches the work AWS normally hides when you use EKS. EC2 is used only as the Linux server platform; Kubernetes itself is installed and managed with **kubeadm**, like a traditional self-managed/on-premises cluster.

## Target Architecture

```text
                         Admin workstation
                        kubectl / SSH access
                                |
                                v
+----------------------------------------------------------------+
|                 AWS VPC used as server network                  |
|                                                                |
|  Control Plane EC2                                             |
|  k8s-cp-01  (Ubuntu 24.04, t3.medium)                          |
|  - kube-apiserver                                              |
|  - kube-controller-manager                                     |
|  - kube-scheduler                                              |
|  - etcd                                                        |
|                                                                |
|  Worker EC2 #1                 Worker EC2 #2                    |
|  k8s-worker-01                 k8s-worker-02                    |
|  - kubelet                     - kubelet                        |
|  - containerd                  - containerd                     |
|  - Calico CNI                  - Calico CNI                     |
+----------------------------------------------------------------+
```

## Build Order

1. `01-ARCHITECTURE-AND-EC2.md`
2. `02-NETWORK-AND-SECURITY.md`
3. `03-PREPARE-UBUNTU-ALL-NODES.md`
4. `04-INSTALL-CONTAINERD.md`
5. `05-INSTALL-KUBERNETES-PACKAGES.md`
6. `06-INITIALIZE-CONTROL-PLANE.md`
7. `07-INSTALL-CALICO-CNI.md`
8. `08-JOIN-WORKERS.md`
9. `09-VALIDATE-CLUSTER.md`
10. `10-ADMIN-KUBECONFIG.md`
11. `11-TROUBLESHOOTING.md`
12. `12-RESET-AND-CLEANUP.md`

## Important Training Point

A kubeadm cluster is **not** an EKS cluster. You own control-plane lifecycle, etcd, OS patching, Kubernetes upgrades, CNI operations and node recovery. That difference is one of the main reasons to learn this track before EKS.


---

# Amazon EKS Track


---

# 1. EKS Prerequisites

## Check local tools

```bash
aws --version
kubectl version --client
eksctl version
helm version
```

## Verify AWS identity and region

```bash
aws sts get-caller-identity
aws configure get region
```

For this training runbook examples use:

```bash
export AWS_REGION=ap-south-1
export CLUSTER_NAME=k8s-training-eks
```

## Confirm EKS Kubernetes Versions Available

Do not assume a version. Check your region/account:

```bash
aws eks describe-cluster-versions --region "$AWS_REGION" 2>/dev/null || true
```

If that command is unavailable in your AWS CLI version, use the EKS console/documentation and upgrade AWS CLI. This course baseline is Kubernetes 1.36.


---

# 2. Create EKS Cluster with eksctl

## Simple Training Cluster

```bash
export AWS_REGION=ap-south-1
export CLUSTER_NAME=k8s-training-eks

aws sts get-caller-identity

eksctl create cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --version 1.36 \
  --managed \
  --nodegroup-name app-ng \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 2 \
  --nodes-max 4
```

## Why start with eksctl?

For teaching, `eksctl` exposes the cluster concepts while avoiding dozens of low-level IAM/VPC CLI calls. After students understand the objects, Terraform can be introduced as the repeatable infrastructure path.

## Validate AWS-side cluster state

```bash
aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.{Status:status,Version:version,Endpoint:endpoint,Platform:platformVersion}' \
  --output table
```


---

# 3. kubeconfig and Validation

```bash
aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME"

kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -A -o wide
```

## Verify EKS Control Plane

```bash
aws eks describe-cluster \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME" \
  --query 'cluster.{Name:name,Version:version,Status:status,Endpoint:endpoint,Auth:accessConfig.authenticationMode}' \
  --output yaml
```

## Verify Node Groups

```bash
aws eks list-nodegroups --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
eksctl get nodegroup --cluster "$CLUSTER_NAME" --region "$AWS_REGION"
```


---

# 4. EKS Access Entries

EKS access entries are the preferred AWS-native mechanism for granting IAM principals access to the Kubernetes API. They separate AWS identity mapping from Kubernetes workload identities.

## Inspect Authentication Mode

```bash
aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.accessConfig'
```

## List Access Entries

```bash
aws eks list-access-entries \
  --cluster-name "$CLUSTER_NAME" \
  --region "$AWS_REGION"
```

## Create Access Entry for an IAM Role

```bash
aws eks create-access-entry \
  --cluster-name "$CLUSTER_NAME" \
  --principal-arn arn:aws:iam::<ACCOUNT_ID>:role/<ROLE_NAME> \
  --type STANDARD \
  --region "$AWS_REGION"
```

Associate an AWS-managed EKS cluster access policy only after deciding the required scope. Do not grant cluster-admin automatically to every engineer.

## Kubernetes RBAC Alternative

An access entry can map an IAM identity to Kubernetes groups, and Kubernetes RoleBindings/ClusterRoleBindings then decide permissions. This is useful when you want fine-grained Kubernetes-native RBAC.


---

# 5. EKS Add-ons

## List Installed Add-ons

```bash
aws eks list-addons \
  --cluster-name "$CLUSTER_NAME" \
  --region "$AWS_REGION"
```

Common core add-ons include:

- VPC CNI
- CoreDNS
- kube-proxy
- EKS Pod Identity Agent (when installed)
- EBS CSI Driver (when installed)

## Inspect Compatible Versions

```bash
aws eks describe-addon-versions \
  --kubernetes-version 1.36 \
  --region "$AWS_REGION" \
  --query 'addons[].{Addon:addonName,Versions:addonVersions[?compatibilities[?defaultVersion==`true`]].addonVersion}'
```

## Describe an Add-on

```bash
aws eks describe-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name coredns \
  --region "$AWS_REGION"
```

Before upgrades, verify add-on compatibility with the target Kubernetes version.


---

# 6. EKS Pod Identity

EKS Pod Identity lets a Kubernetes ServiceAccount obtain AWS permissions through an IAM role without placing static AWS keys in Pods.

## Install Pod Identity Agent Add-on

```bash
aws eks create-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name eks-pod-identity-agent \
  --region "$AWS_REGION"
```

If it already exists, inspect it instead:

```bash
aws eks describe-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name eks-pod-identity-agent \
  --region "$AWS_REGION"
```

## Verify Agent

```bash
kubectl get pods -n kube-system | grep pod-identity
```

## Pod Identity Flow

```text
Pod
  ↓ uses ServiceAccount
EKS Pod Identity Agent
  ↓ association
IAM Role
  ↓ temporary credentials
AWS API
```

Use one IAM role per workload responsibility where practical. Do not attach broad application permissions to every node role.


---

# 7. EBS CSI Driver

The EBS CSI driver is required when EKS workloads use Amazon EBS-backed PersistentVolumes.

## Create a Pod Identity IAM Role

Create a trust policy file:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"Service": "pods.eks.amazonaws.com"},
      "Action": ["sts:AssumeRole", "sts:TagSession"]
    }
  ]
}
```

```bash
aws iam create-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --assume-role-policy-document file://pod-identity-trust.json

aws iam attach-role-policy \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy
```

## Associate Role with EBS CSI ServiceAccount

```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws eks create-pod-identity-association \
  --cluster-name "$CLUSTER_NAME" \
  --namespace kube-system \
  --service-account ebs-csi-controller-sa \
  --role-arn "arn:aws:iam::${ACCOUNT_ID}:role/AmazonEKS_EBS_CSI_DriverRole" \
  --region "$AWS_REGION"
```

## Install EBS CSI Add-on

```bash
aws eks create-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name aws-ebs-csi-driver \
  --region "$AWS_REGION"
```

## Verify

```bash
kubectl get pods -n kube-system | grep ebs-csi
kubectl get csidrivers
kubectl get storageclass
```


---

# 8. Metrics Server and HPA

## Install Metrics Server

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

## Validate

```bash
kubectl rollout status deployment/metrics-server -n kube-system
kubectl top nodes
kubectl top pods -A
```

HPA based on CPU/memory usually needs workload resource requests so utilization percentages have a meaningful baseline.

```bash
kubectl get apiservice v1beta1.metrics.k8s.io
```


---

# 9. AWS Load Balancer Controller — Complete Lab

The AWS Load Balancer Controller watches Kubernetes Service/Ingress resources and provisions/configures AWS ALB/NLB resources.

This lab uses **IRSA** for the controller because the official EKS installation flow provides an explicit, repeatable command sequence. EKS Pod Identity is also supported by the controller; do not attach the controller policy broadly to every worker node.

## Step 1 — Associate an IAM OIDC Provider

```bash
eksctl utils associate-iam-oidc-provider \
  --cluster "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --approve
```

Verify:

```bash
aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.identity.oidc.issuer' \
  --output text
```

## Step 2 — Download the Controller IAM Policy

The AWS EKS guide currently documents controller v2.14.1 for this installation flow:

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/install/iam_policy.json
```

Review before creating the policy:

```bash
python -m json.tool iam_policy.json >/dev/null && echo 'JSON valid'
less iam_policy.json
```

## Step 3 — Create IAM Policy

```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json
```

If the policy already exists, get its ARN:

```bash
LBC_POLICY_ARN=$(aws iam list-policies \
  --scope Local \
  --query "Policies[?PolicyName=='AWSLoadBalancerControllerIAMPolicy'].Arn | [0]" \
  --output text)

echo "$LBC_POLICY_ARN"
```

For a newly created policy you can also construct:

```bash
LBC_POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/AWSLoadBalancerControllerIAMPolicy"
```

## Step 4 — Create IAM Role + Kubernetes ServiceAccount

```bash
eksctl create iamserviceaccount \
  --cluster "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn "$LBC_POLICY_ARN" \
  --override-existing-serviceaccounts \
  --approve
```

Verify:

```bash
kubectl get serviceaccount aws-load-balancer-controller -n kube-system -o yaml
```

## Step 5 — Add Helm Repository

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
```

## Step 6 — Install Controller

```bash
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="$CLUSTER_NAME" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --version 1.14.0
```

If your nodes have restricted IMDS access, Fargate is used, or network discovery requires it, include region and VPC explicitly:

```bash
VPC_ID=$(aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.resourcesVpcConfig.vpcId' \
  --output text)

helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="$CLUSTER_NAME" \
  --set region="$AWS_REGION" \
  --set vpcId="$VPC_ID" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --version 1.14.0
```

## Step 7 — Verify

```bash
kubectl get deployment aws-load-balancer-controller -n kube-system
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller
kubectl logs -n kube-system deployment/aws-load-balancer-controller --tail=100
```

Expected: controller Deployment available and Pods Running/Ready.

## Upgrade Note

The Helm chart does not automatically receive future security updates. Before upgrading the controller, review release notes. When using `helm upgrade`, install/update the CRDs as documented by the controller:

```bash
wget https://raw.githubusercontent.com/aws/eks-charts/master/stable/aws-load-balancer-controller/crds/crds.yaml
kubectl apply -f crds.yaml
```


---

# 10. EKS Observability

## Enable Control Plane Logs

```bash
aws eks update-cluster-config \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --logging '{"clusterLogging":[{"types":["api","audit","authenticator","controllerManager","scheduler"],"enabled":true}]}'
```

Check status:

```bash
aws eks describe-update \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --update-id <UPDATE_ID>
```

## Kubernetes-side Checks

```bash
kubectl get events -A --sort-by=.lastTimestamp
kubectl top nodes
kubectl top pods -A
kubectl get pods -n kube-system -o wide
```

Production monitoring normally adds Prometheus-compatible metrics, dashboards, centralized logs and alerting tied to SLOs.


---

# 11. Scaling in EKS

There are two different scaling questions:

```text
HPA -> Do I need more/fewer Pods?
Node autoscaler / Karpenter / EKS Auto Mode -> Do I need more/fewer nodes/capacity?
```

## Managed Node Group Limits

```bash
eksctl get nodegroup --cluster "$CLUSTER_NAME" --region "$AWS_REGION"
```

Example scaling update:

```bash
eksctl scale nodegroup \
  --cluster "$CLUSTER_NAME" \
  --name app-ng \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 5 \
  --region "$AWS_REGION"
```

For production, choose one capacity-management strategy deliberately. Avoid installing multiple autoscaling systems that fight over the same nodes.


---

# 12. EKS Security Checklist

## Identity

```bash
aws eks list-access-entries --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
kubectl auth can-i --list
```

## Network

- Decide whether public API endpoint access is required.
- Restrict public endpoint CIDRs when used.
- Use private endpoints for private administration patterns where appropriate.
- Use Security Groups and NetworkPolicy as complementary controls.

## Workload Identity

Use EKS Pod Identity or IRSA for AWS API access from Pods. Do not put AWS access keys in Secrets/environment variables for long-lived workload authentication.

## Pods

```bash
kubectl get ns --show-labels
kubectl get networkpolicy -A
kubectl get role,rolebinding -A
```

Apply non-root, seccomp, capability dropping and controlled images based on workload compatibility.


---

# 13. EKS Upgrade Runbook

## 1. Record current versions

```bash
aws eks describe-cluster --name "$CLUSTER_NAME" --region "$AWS_REGION" --query 'cluster.{Version:version,Platform:platformVersion}'
aws eks list-addons --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
kubectl get nodes -o wide
```

## 2. Check upgrade insights / deprecated APIs

Review EKS upgrade insights and application API compatibility before changing the cluster version.

## 3. Upgrade control plane

Upgrade one supported minor-version step at a time following current EKS rules and your change process.

## 4. Update add-ons

For each add-on, inspect versions compatible with the target Kubernetes version:

```bash
aws eks describe-addon-versions --kubernetes-version <TARGET_VERSION> --region "$AWS_REGION"
```

## 5. Update node groups

```bash
eksctl upgrade nodegroup --cluster "$CLUSTER_NAME" --name app-ng --region "$AWS_REGION"
```

## 6. Validate workloads

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp
```


---

# 14. EKS Cleanup

Before deleting the cluster, delete Kubernetes resources that created external AWS load balancers so controllers have a chance to clean them up.

```bash
kubectl get ingress -A
kubectl get svc -A | grep LoadBalancer || true
```

Delete training namespaces/applications, then delete the cluster:

```bash
eksctl delete cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION"
```

Check for leftovers:

```bash
aws eks list-clusters --region "$AWS_REGION"
aws elbv2 describe-load-balancers --region "$AWS_REGION" --output table
aws ec2 describe-volumes --region "$AWS_REGION" --filters Name=status,Values=available --output table
```

Also review NAT Gateways, EBS volumes, load balancers and CloudWatch log groups for lab resources that may continue to incur cost.


---

# Amazon EKS — Command Runbook

```bash
export AWS_REGION=ap-south-1
export CLUSTER_NAME=k8s-training-eks

aws sts get-caller-identity

eksctl create cluster --name "$CLUSTER_NAME" --region "$AWS_REGION" --version 1.36 --managed --nodegroup-name app-ng --node-type t3.medium --nodes 2 --nodes-min 2 --nodes-max 4

aws eks update-kubeconfig --region "$AWS_REGION" --name "$CLUSTER_NAME"
kubectl get nodes -o wide
kubectl get pods -A -o wide

aws eks list-access-entries --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
aws eks list-addons --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl top nodes

helm repo add eks https://aws.github.io/eks-charts
helm repo update

kubectl get events -A --sort-by=.lastTimestamp
```


---

# Amazon EKS — Managed Kubernetes Track

This track starts only after students understand the kubeadm cluster. The goal is to identify what AWS manages for you and what still remains your responsibility.

## Responsibility Split

```text
AWS manages:
- Kubernetes control plane availability
- control-plane infrastructure lifecycle
- managed API endpoint integration

You still manage:
- worker capacity / node groups / Auto Mode choice
- Kubernetes workloads and namespaces
- RBAC / EKS access
- add-ons and their compatibility
- networking design and security
- ingress/load balancing
- storage drivers and workload data
- monitoring, cost and upgrades
```

## Build Order

1. prerequisites
2. VPC/network design
3. create EKS 1.36 cluster
4. kubeconfig and validation
5. managed node groups
6. access entries
7. EKS add-ons
8. Pod Identity
9. EBS CSI
10. Metrics Server
11. AWS Load Balancer Controller
12. observability
13. scaling
14. security
15. upgrades
16. cleanup
