# First App on Minikube

From repository root:

```bash
kubectl apply -f applications/first-kubernetes-app/
kubectl get all -n student-app
```

Access:

```bash
kubectl port-forward -n student-app svc/student-web 8080:80
```

Open `http://localhost:8080`.

Self-healing:

```bash
kubectl get pods -n student-app
kubectl delete pod <pod-name> -n student-app
kubectl get pods -n student-app -w
```
