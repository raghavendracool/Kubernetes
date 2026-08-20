# Kubernetes YAML Review Checklist

- [ ] Correct `apiVersion` and `kind`.
- [ ] Namespace is intentional.
- [ ] Labels are consistent.
- [ ] Selectors match Pod-template labels.
- [ ] Images use controlled tags/digests.
- [ ] Resource requests are set.
- [ ] Limits are intentional.
- [ ] Readiness/liveness/startup probes make sense.
- [ ] Service `targetPort` matches application port.
- [ ] Secrets are not hard-coded in Git.
- [ ] `securityContext` follows least privilege.
- [ ] PDB / anti-affinity / spread are considered for critical workloads.
- [ ] `kubectl apply --dry-run=server` passes.
- [ ] `kubectl diff` was reviewed.
