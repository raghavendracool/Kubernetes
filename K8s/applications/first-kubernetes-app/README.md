# First Kubernetes Application

Same manifests are used on Minikube, kubeadm and EKS.

```bash
kubectl apply -f applications/first-kubernetes-app/
kubectl get all -n student-app
```

Initial image is NGINX so students need no registry account. Later replace it with the custom Flask image.
