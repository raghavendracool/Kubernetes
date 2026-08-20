# Module 06 — Labels, Selectors and Namespaces

## 1. What Will We Learn?

**Outcome:** Organize objects and understand how Kubernetes resources find each other.

## 2. The 3 Whys

1. **WHY #1 — Why labels? Objects need flexible grouping metadata.**
2. **WHY #2 — Why selectors? Controllers and Services need to target matching objects.**
3. **WHY #3 — Why namespaces? Teams/environments need logical scope and policy boundaries.**

## 3. Problem Before This Concept

Kubernetes objects should never be memorized as random YAML. First identify the operational problem, then understand the Kubernetes resource or component that solves it.

## 4. Easy Real-Life Analogy

Labels are badges, selectors are filters, namespaces are departments.

## 5. Core Architecture Mental Model

```text
Desired State
    ↓
Kubernetes API
    ↓
Controllers / Scheduler / Node Agents
    ↓
Actual State
    ↓
Continuous Reconciliation
```

## 6. What Happens Internally?

1. A user or controller sends a request to the API server.
2. The request is authenticated, authorized and validated.
3. Accepted desired state is stored through the Kubernetes API.
4. Controllers watch resources and reconcile dependent resources.
5. Scheduler assigns unscheduled Pods to suitable nodes.
6. kubelet works with the container runtime to start assigned containers.
7. Status is reported back and reconciliation continues.

Not every object uses every step, but this is the pattern students should recognize.

## 7. Hands-On Lab

Query Pods using app/version/environment labels and selectors.

If this module contains a progressive `stage/` folder:

```bash
bash scripts/load-module.sh 6
cd kubernetes-live/manifests
kubectl apply -f .
```

## 8. Commands

```bash
kubectl get pods --show-labels -n student-app
```

```bash
kubectl get pods -l app=student-web -n student-app
```

```bash
kubectl get ns
```

For each command explain:
- resource;
- namespace;
- read vs change;
- expected success;
- common failure.

## 9. Validation

Start with:

```bash
kubectl get nodes -o wide
kubectl get pods -A
kubectl get events -A --sort-by=.lastTimestamp
```

Then validate the specific object taught in this module.

## 10. Break It Intentionally

Students must change one setting so the lab fails, capture evidence, restore it and validate the recovery.

## 11. Troubleshooting Flow

```text
Symptom
  ↓
kubectl get
  ↓
kubectl describe
  ↓
Events
  ↓
Logs (if container/app issue)
  ↓
Config / resource / network / auth checks
  ↓
Root cause
  ↓
Fix
  ↓
Validation
```

## 12. Production Best Practices

- Use consistent labels.
- Namespaces alone are not a complete security boundary.
- Keep selector/template labels aligned.

## 13. Common Mistakes

- Copying YAML without understanding selectors or ownership.
- Using the `default` namespace for everything.
- Using `latest` in production.
- Applying changes before reading current status/events.
- Using cluster-admin to avoid learning RBAC.
- Troubleshooting at the wrong layer.

## 14. Interview Questions

1. Labels vs annotations?
2. Can namespaces contain same object names?
3. What if Deployment selector mismatches Pod labels?

## 15. Student Assignment

1. Draw this concept without looking at notes.
2. Run the lab.
3. Save `get` and `describe` evidence.
4. Break one configuration.
5. Find root cause.
6. Fix it.
7. Explain the concept in under three minutes.

## 16. Cleanup

For isolated labs:

```bash
kubectl delete -f . --ignore-not-found
```

Shared objects may be retained when the next module builds on them.
