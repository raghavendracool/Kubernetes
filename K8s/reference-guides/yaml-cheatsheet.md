# Kubernetes YAML Cheat Sheet

```yaml
apiVersion: ...
kind: ...
metadata:
  name: ...
  namespace: ...
  labels: {}
spec:
  ...
```

Ask:
1. Which API owns this field?
2. Is it required?
3. What is the default?
4. What does `kubectl explain` say?
5. How will validation fail?
