# Module 12 — StatefulSet, DaemonSet, Job and CronJob: Hands-On Lab

## Objective
Compare controller behavior rather than treating every workload as a Deployment.

```bash
kubectl create namespace controller-lab
kubectl create job hello --image=busybox:1.36 -n controller-lab -- sh -c 'echo job-start; sleep 2; echo job-done'
kubectl get job,pods -n controller-lab
kubectl logs job/hello -n controller-lab
```

CronJob:

```bash
kubectl create cronjob heartbeat --image=busybox:1.36 --schedule='*/2 * * * *' -n controller-lab -- sh -c 'date; echo heartbeat'
kubectl get cronjob -n controller-lab
```

Create a DaemonSet:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-agent
  namespace: controller-lab
spec:
  selector:
    matchLabels: {app: node-agent}
  template:
    metadata:
      labels: {app: node-agent}
    spec:
      containers:
        - name: agent
          image: busybox:1.36
          command: ["sh","-c","while true; do echo node-agent; sleep 60; done"]
EOF
```

Create a headless Service + StatefulSet:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: stateful-demo
  namespace: controller-lab
spec:
  clusterIP: None
  selector: {app: stateful-demo}
  ports:
    - port: 80
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: stateful-demo
  namespace: controller-lab
spec:
  serviceName: stateful-demo
  replicas: 2
  selector:
    matchLabels: {app: stateful-demo}
  template:
    metadata:
      labels: {app: stateful-demo}
    spec:
      containers:
        - name: web
          image: nginx:alpine
          ports:
            - containerPort: 80
EOF
```

Verify:

```bash
kubectl get ds,sts,pods -n controller-lab -o wide
```

For each controller, state what causes new Pods to be created and what identity guarantees exist.

```bash
kubectl delete namespace controller-lab
```
