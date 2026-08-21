# Module 12 â€” StatefulSet, DaemonSet, Job and CronJob

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

## 7. Command Workflow â€” Do Not Skip Verification

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

## 13A. See Also

- Course roadmap: `../../00-Course-Guide/01-COURSE-ROADMAP.md`
- YAML checklist: `../../05-Cheat-Sheets/yaml-checklist.md`
- Applications practice: `../../03-Applications/README.md`
- Continue with the next module folder in sequence.

## 14. Module Completion Checklist

- [ ] I can explain the topic using What / Why / Where.
- [ ] I can run and explain every command in `COMMANDS.md`.
- [ ] I completed `LAB.md`.
- [ ] I can inspect the generated YAML.
- [ ] I can identify at least three failure scenarios.
- [ ] I performed cleanup.
