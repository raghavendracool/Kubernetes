# Break/Fix Lab Method

For every scenario record:

1. Symptom
2. First command
3. Evidence
4. Root cause
5. Fix
6. Validation

Start:

```bash
kubectl get pods -n student-app
kubectl describe pod <pod> -n student-app
kubectl get events -n student-app --sort-by=.lastTimestamp
kubectl logs <pod> -n student-app
kubectl logs <pod> -n student-app --previous
```
