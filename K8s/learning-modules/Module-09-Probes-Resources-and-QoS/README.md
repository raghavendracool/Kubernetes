# Module 09 — Probes, Resource Requests/Limits and QoS

## 1. What Will We Learn?

**Outcome:** Teach Kubernetes when an app is started, ready, healthy and how much resource it needs.

## 2. The 3 Whys

1. **WHY #1 — Why probes? Running process does not always mean healthy app.**
2. **WHY #2 — Why requests? Scheduler needs expected demand.**
3. **WHY #3 — Why limits? Workloads should not consume unlimited node resources.**

## 3. Problem Before This Concept

Kubernetes objects should never be memorized as random YAML. First identify the operational problem, then understand the Kubernetes resource or component that solves it.

## 4. Easy Real-Life Analogy

Startup asks 'opened?', readiness asks 'can customers enter?', liveness asks 'still healthy?'

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

Add readiness/liveness probes and CPU/memory requests/limits.

If this module contains a progressive `stage/` folder:

```bash
bash scripts/load-module.sh 9
cd kubernetes-live/manifests
kubectl apply -f .
```

## 8. Commands

```bash
kubectl describe pod -n student-app
```

```bash
kubectl top pods -n student-app
```

```bash
kubectl get pod POD -n student-app -o jsonpath='{.status.qosClass}'
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

- Measure requests.
- Use startup probes for slow apps.
- Do not make liveness too aggressive.

## 13. Common Mistakes

- Copying YAML without understanding selectors or ownership.
- Using the `default` namespace for everything.
- Using `latest` in production.
- Applying changes before reading current status/events.
- Using cluster-admin to avoid learning RBAC.
- Troubleshooting at the wrong layer.

## 14. Interview Questions

1. Readiness vs liveness?
2. Requests vs limits?
3. What causes OOMKilled?

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
