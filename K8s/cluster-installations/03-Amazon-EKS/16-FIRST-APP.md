# 16 — Same First App on EKS

```bash
kubectl apply -f applications/first-kubernetes-app/
kubectl get all -n student-app
```

Internal validation:

```bash
kubectl run curl-test -n student-app --rm -it --restart=Never   --image=curlimages/curl -- curl -I http://student-web
```
