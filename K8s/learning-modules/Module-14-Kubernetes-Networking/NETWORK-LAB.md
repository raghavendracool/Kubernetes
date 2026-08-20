# Networking Lab

```bash
kubectl run netshoot -n student-app --image=nicolaka/netshoot -- sleep 3600
kubectl exec -it -n student-app netshoot -- nslookup student-web
kubectl exec -it -n student-app netshoot -- curl -I http://student-web
kubectl get pod -n student-app -o wide
kubectl get svc,endpoints,endpointslices -n student-app
```

Troubleshoot in layers:

1. Pod Ready?
2. DNS resolves?
3. Service has endpoints?
4. TCP connects?
5. HTTP/application responds?
