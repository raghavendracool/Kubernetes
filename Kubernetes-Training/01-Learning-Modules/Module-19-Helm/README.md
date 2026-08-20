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
