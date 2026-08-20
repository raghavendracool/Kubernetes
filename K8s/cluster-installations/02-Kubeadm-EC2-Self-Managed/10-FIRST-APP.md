# 10 — Same First App

```bash
kubectl apply -f applications/first-kubernetes-app/
kubectl get all -n student-app -o wide
```

Internal test:

```bash
kubectl run curl-test -n student-app --rm -it --restart=Never   --image=curlimages/curl -- curl -I http://student-web
```

Delete one Pod and watch the Deployment restore it.
