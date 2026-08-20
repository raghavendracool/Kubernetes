# Troubleshooting Cheat Sheet

| Symptom | First commands |
|---|---|
| Pod Pending | `kubectl describe pod`, `kubectl get events` |
| CrashLoopBackOff | `kubectl logs`, `kubectl logs --previous`, `kubectl describe pod` |
| ImagePullBackOff | `kubectl describe pod`, inspect image + pull secret |
| Service not reachable | `kubectl get svc,endpointslice`, Pod readiness, targetPort |
| DNS issue | `kubectl get pods -n kube-system`, `nslookup`, CNI connectivity |
| PVC Pending | `kubectl describe pvc`, `kubectl get storageclass`, CSI pods |
| Node NotReady | `kubectl describe node`, `systemctl status kubelet`, `systemctl status containerd` |
| Forbidden | `kubectl auth can-i`, Roles/Bindings, EKS access identity |
| HPA unknown | `kubectl top pods`, Metrics Server, requests |
| Ingress no address | controller logs/events, ingressClass, cloud permissions |
