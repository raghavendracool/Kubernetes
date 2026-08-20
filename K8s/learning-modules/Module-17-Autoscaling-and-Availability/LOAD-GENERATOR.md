# HPA Load Generator

```bash
kubectl run -it --rm load-generator   --image=busybox:1.36   --restart=Never   -n student-app -- /bin/sh
```

Inside:

```sh
while true; do wget -q -O- http://student-web; done
```

Watch:

```bash
kubectl get hpa -n student-app -w
kubectl get pods -n student-app -w
```
