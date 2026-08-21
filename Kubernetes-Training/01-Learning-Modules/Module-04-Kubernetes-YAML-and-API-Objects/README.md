# Module 04 — Kubernetes YAML and API Objects

## 1. Module Goal

By the end of this module, students should be able to:

- Explain Kubernetes resources as API objects.
- Read a manifest from top to bottom.
- Explain `apiVersion`, `kind`, `metadata`, `spec`, and `status`.
- Understand desired state vs observed state.
- Discover resource kinds and API versions from the cluster instead of memorizing a fixed count.
- Explain namespaced vs cluster-scoped resources.
- Understand built-in resources vs CRD-based custom resources.
- Generate, validate, diff, apply, inspect, and delete YAML.
- Use `kubectl explain` instead of guessing fields.

---

## 2. Kubernetes Is API-Driven

A YAML file is a request for desired state.

```text
YAML / kubectl
      |
      v
kube-apiserver
      |
      +--> authentication
      +--> authorization
      +--> admission
      +--> schema validation
      |
      v
     etcd
      |
      v
Controllers / Scheduler / Kubelet
      |
      v
Actual cluster state
```

Example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-demo
spec:
  containers:
    - name: nginx
      image: nginx:1.28-alpine
```

Kubernetes stores the desired object and continuously works to make actual state match it.

---

## 3. Declarative vs Imperative

### Imperative

```bash
kubectl run nginx --image=nginx:1.28-alpine
```

Good for quick tests and troubleshooting.

### Declarative

```bash
kubectl apply -f pod.yaml
```

Better for repeatability, Git, code review, CI/CD, and production change management.

---

## 4. Standard Manifest Structure

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  namespace: default
  labels:
    app: web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: nginx
          image: nginx:1.28-alpine
          ports:
            - containerPort: 80
```

| Field | Meaning |
|---|---|
| `apiVersion` | API group/version containing the resource schema |
| `kind` | Resource type to create |
| `metadata` | Name, namespace, labels, annotations |
| `spec` | Desired state supplied by the user |
| `status` | Observed state maintained by Kubernetes |

Normally you define `spec`; Kubernetes writes `status`.

---

## 5. Understanding `apiVersion`

### Core API group

Examples using `v1`:

```text
Pod
Service
ConfigMap
Secret
Namespace
Node
PersistentVolume
PersistentVolumeClaim
ServiceAccount
```

```yaml
apiVersion: v1
```

### Named API groups

| API group/version | Common kinds |
|---|---|
| `apps/v1` | Deployment, ReplicaSet, StatefulSet, DaemonSet |
| `batch/v1` | Job, CronJob |
| `networking.k8s.io/v1` | Ingress, NetworkPolicy |
| `rbac.authorization.k8s.io/v1` | Role, RoleBinding, ClusterRole, ClusterRoleBinding |
| `autoscaling/v2` | HorizontalPodAutoscaler |
| `policy/v1` | PodDisruptionBudget |
| `storage.k8s.io/v1` | StorageClass, CSIDriver |

Discover versions:

```bash
kubectl api-versions
```

---

## 6. How Many Kubernetes `kind`s Are There?

There is **no single fixed number to memorize**.

The exact set depends on:

1. Kubernetes version.
2. Enabled APIs.
3. Installed add-ons.
4. Installed CRDs.

The correct command is:

```bash
kubectl api-resources
```

Detailed:

```bash
kubectl api-resources -o wide
```

Namespaced only:

```bash
kubectl api-resources --namespaced=true
```

Cluster-scoped only:

```bash
kubectl api-resources --namespaced=false
```

### Common kinds by category

**Workloads**

```text
Pod
ReplicaSet
Deployment
StatefulSet
DaemonSet
Job
CronJob
```

**Networking**

```text
Service
Ingress
NetworkPolicy
EndpointSlice
```

**Configuration**

```text
ConfigMap
Secret
```

**Storage**

```text
PersistentVolume
PersistentVolumeClaim
StorageClass
```

**Identity / RBAC**

```text
ServiceAccount
Role
RoleBinding
ClusterRole
ClusterRoleBinding
```

**Scaling / Availability**

```text
HorizontalPodAutoscaler
PodDisruptionBudget
```

**Cluster**

```text
Node
Namespace
CustomResourceDefinition
```

CRDs can add new kinds such as `Certificate`, `ServiceMonitor`, `Application`, or others depending on installed software.

---

## 7. Namespaced vs Cluster-Scoped

### Namespaced

Examples:

```text
Pod
Deployment
Service
ConfigMap
Secret
Role
RoleBinding
PersistentVolumeClaim
```

Check:

```bash
kubectl api-resources --namespaced=true
```

### Cluster-scoped

Examples:

```text
Node
Namespace
PersistentVolume
StorageClass
ClusterRole
ClusterRoleBinding
CustomResourceDefinition
```

Check:

```bash
kubectl api-resources --namespaced=false
```

---

## 8. `metadata`

```yaml
metadata:
  name: training-web
  namespace: training
  labels:
    app: training-web
    tier: frontend
  annotations:
    owner: devops-training
```

### Labels

Used for identification and selection.

```yaml
labels:
  app: web
  environment: dev
```

### Annotations

Extra metadata, normally not used as selectors.

```yaml
annotations:
  owner: platform-team
```

---

## 9. `spec` vs `status`

Desired state:

```yaml
spec:
  replicas: 3
```

Observed state might later show:

```yaml
status:
  replicas: 3
  readyReplicas: 3
  availableReplicas: 3
```

Mental model:

```text
Desired = 3
Actual  = 2
     |
Controller reconciles
     |
Actual  = 3
```

---

## 10. YAML Basics Students Must Know

### Key/value

```yaml
name: nginx
```

### Map

```yaml
labels:
  app: web
  tier: frontend
```

### List

```yaml
ports:
  - 80
  - 443
```

### List of maps

```yaml
containers:
  - name: nginx
    image: nginx:1.28-alpine
  - name: helper
    image: busybox:1.36
```

### Boolean

```yaml
readOnlyRootFilesystem: true
```

### Multi-object file

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: demo
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  namespace: demo
spec:
  containers:
    - name: nginx
      image: nginx:1.28-alpine
```

`---` separates YAML documents.

Use spaces, not tabs.

---

## 11. Complete Pod YAML

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  restartPolicy: Always
  containers:
    - name: nginx
      image: nginx:1.28-alpine
      ports:
        - name: http
          containerPort: 80
          protocol: TCP
      resources:
        requests:
          cpu: "50m"
          memory: "64Mi"
        limits:
          cpu: "200m"
          memory: "128Mi"
```

Read it as:

```text
apiVersion -> Which API schema?
kind       -> What object?
metadata   -> Identity and labels
spec       -> Desired Pod configuration
containers -> Processes/images inside the Pod
resources  -> Scheduler requests and runtime limits
```

---

## 12. Complete Deployment YAML

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: training-web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: training-web
  template:
    metadata:
      labels:
        app: training-web
    spec:
      containers:
        - name: nginx
          image: nginx:1.28-alpine
          ports:
            - containerPort: 80
```

Important:

```text
Deployment selector
app=training-web
       |
       v
Pod template labels
app=training-web
```

These must match.

---

## 13. Complete Service YAML

```yaml
apiVersion: v1
kind: Service
metadata:
  name: training-web
spec:
  type: ClusterIP
  selector:
    app: training-web
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
```

Service types are covered deeply in Module 08.

---

## 14. Use `kubectl explain`

```bash
kubectl explain pod
kubectl explain pod.spec
kubectl explain pod.spec.containers
kubectl explain deployment.spec
kubectl explain service.spec.type
```

Recursive:

```bash
kubectl explain deployment --recursive
```

This is better than guessing fields from memory.

---

## 15. Generate Starter YAML

Pod:

```bash
kubectl run nginx \
  --image=nginx:1.28-alpine \
  --dry-run=client \
  -o yaml > pod.yaml
```

Deployment:

```bash
kubectl create deployment web \
  --image=nginx:1.28-alpine \
  --dry-run=client \
  -o yaml > deployment.yaml
```

Service:

```bash
kubectl create service clusterip web \
  --tcp=80:80 \
  --dry-run=client \
  -o yaml > service.yaml
```

Generated YAML is a starting point, not a replacement for understanding the schema.

---

## 16. Validate Before Apply

Client-side:

```bash
kubectl apply --dry-run=client -f deployment.yaml
```

Server-side:

```bash
kubectl apply --dry-run=server -f deployment.yaml
```

Preview differences:

```bash
kubectl diff -f deployment.yaml
```

Apply:

```bash
kubectl apply -f deployment.yaml
```

---

## 17. Inspect Stored Objects

```bash
kubectl get deployment web -o yaml
kubectl get deployment web -o json
kubectl describe deployment web
```

Useful output forms:

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods \
  -o custom-columns=NAME:.metadata.name,PHASE:.status.phase,NODE:.spec.nodeName
```

JSONPath:

```bash
kubectl get pod nginx -o jsonpath='{.status.podIP}'
```

---

## 18. Common YAML/API Failures

### `no matches for kind`

Check:

```bash
kubectl api-resources
kubectl api-versions
kubectl get crd
```

### Unknown field

Use:

```bash
kubectl explain <resource>.<field>
```

### Wrong namespace

```bash
kubectl get <resource> -A
```

### Selector mismatch

Compare controller/Service selector with Pod labels.

---

## 19. Classroom Demo Flow

```text
1. kubectl api-resources
2. Explain why there is no fixed kind count
3. Generate Pod YAML
4. Explain apiVersion/kind/metadata/spec
5. Apply the Pod
6. Inspect stored YAML and status
7. Use kubectl explain
8. Show complete Deployment YAML
9. Show selector ↔ labels
10. Dry-run
11. Diff
12. Apply
13. Cleanup
```

---

## 20. Files in This Module

```text
Module-04-Kubernetes-YAML-and-API-Objects/
├── README.md
├── DETAILED-NOTES.md
├── COMMANDS.md
├── LAB.md
└── examples/
    ├── 01-pod-complete.yaml
    ├── 02-deployment-complete.yaml
    ├── 03-service-complete.yaml
    └── 04-multi-object.yaml
```

---

## 21. Interview Questions

1. What is a Kubernetes API object?
2. `spec` vs `status`?
3. What does `apiVersion` mean?
4. Is there a fixed number of Kubernetes kinds?
5. How do you list resources supported by the current cluster?
6. Namespaced vs cluster-scoped?
7. Why use declarative YAML?
8. What does `kubectl explain` do?
9. Client vs server dry-run?
10. What is a CRD?
11. Why must Deployment selector and Pod template labels match?

## 21A. See Also

- Course roadmap: `../../00-Course-Guide/01-COURSE-ROADMAP.md`
- YAML checklist: `../../05-Cheat-Sheets/yaml-checklist.md`
- Applications practice: `../../03-Applications/README.md`
- Continue with the next module folder in sequence.

---

## 22. Completion Checklist

- [ ] I can explain the main manifest sections.
- [ ] I understand desired vs observed state.
- [ ] I can discover resource kinds.
- [ ] I can identify namespaced vs cluster-scoped resources.
- [ ] I can use `kubectl explain`.
- [ ] I can generate and validate YAML.
- [ ] I can read Pod, Deployment, and Service YAML.
- [ ] I completed `LAB.md`.

## Official References

- https://kubernetes.io/docs/concepts/overview/working-with-objects/
- https://kubernetes.io/docs/reference/using-api/
- https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-resources/
