# Kubernetes Complete Command Catalog


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
