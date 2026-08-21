# Local Laptop/Desktop Deployment

This section explains how students can build and deploy this application completely on their own laptop/Desktop.

For this local lab, **Docker Hub is NOT required**.

We will:

```text
Dockerfile
    ↓
Build Docker Image Locally
    ↓
Test Docker Container
    ↓
Load Image into kind
    ↓
Kubernetes Deployment
    ↓
ReplicaSet
    ↓
Pods
    ↓
Service
    ↓
Browser
```

---

## Prerequisites

Before starting, make sure the local Kubernetes lab is already running.

Check:

```bash
docker version
kubectl version --client
kind version
```

Verify the Kubernetes cluster:

```bash
kubectl get nodes
```

Expected:

```text
NAME                         STATUS   ROLES
k8s-training-control-plane   Ready    control-plane
k8s-training-worker          Ready    <none>
k8s-training-worker2         Ready    <none>
```

Check the kind cluster:

```bash
kind get clusters
```

Expected:

```text
k8s-training
```

---

# Step 1 — Clone the Repository

Open Ubuntu WSL.

```bash
cd ~
```

Clone:

```bash
git clone https://github.com/raghavendracool/Kubernetes.git
```

Enter the application directory:

```bash
cd ~/Kubernetes/Kubernetes-Training/03-Applications/App-01-Nginx-Training-Web
```

Check files:

```bash
ls
```

Expected:

```text
Dockerfile
README.md
html
kubernetes
```

---

# Step 2 — Understand the Application

The application is a simple Nginx web application.

```text
html/index.html
       ↓
Dockerfile
       ↓
Nginx Docker Image
       ↓
Kubernetes Pods
```

Check the Dockerfile:

```bash
cat Dockerfile
```

Check the application page:

```bash
cat html/index.html
```

---

# Step 3 — Build the Docker Image Locally

Run:

```bash
docker build -t k8s-training-web:v1 .
```

Verify:

```bash
docker images
```

Or:

```bash
docker images | grep k8s-training-web
```

Expected:

```text
k8s-training-web    v1
```

At this point:

```text
Dockerfile
     ↓
docker build
     ↓
k8s-training-web:v1
```

The image exists only on your local laptop.

---

# Step 4 — Test the Application with Docker First

Before deploying to Kubernetes, verify that the Docker image works.

Run:

```bash
docker run -d \
  --name nginx-test \
  -p 8080:80 \
  k8s-training-web:v1
```

Check:

```bash
docker ps
```

Test using curl:

```bash
curl http://localhost:8080
```

Or open the browser on Windows:

```text
http://localhost:8080
```

You should see the Nginx training application.

---

# Step 5 — Remove the Docker Test Container

After testing:

```bash
docker rm -f nginx-test
```

Verify:

```bash
docker ps
```

---

# Step 6 — Load the Local Docker Image into kind

This is an important step.

The image currently exists in Docker Desktop:

```text
k8s-training-web:v1
```

But the kind Kubernetes nodes need access to the image.

Run:

```bash
kind load docker-image k8s-training-web:v1 \
  --name k8s-training
```

The flow is:

```text
Local Docker Image
        ↓
kind load docker-image
        ↓
Control Plane / Worker Nodes
        ↓
Kubernetes can use the image
```

No Docker Hub is required.

---

# Step 7 — Configure the Deployment for Local Image

Open:

```bash
nano kubernetes/01-deployment.yaml
```

For the local kind environment, use:

```yaml
image: k8s-training-web:v1
```

Recommended:

```yaml
imagePullPolicy: IfNotPresent
```

Example:

```yaml
containers:
  - name: training-web
    image: k8s-training-web:v1
    imagePullPolicy: IfNotPresent
```

Do not use:

```yaml
image: <REGISTRY_USER>/k8s-training-web:v1
```

for this local kind lab.

That registry format will be used later when learning Docker Hub/ECR.

---

# Step 8 — Create Namespace

Apply:

```bash
kubectl apply -f kubernetes/00-namespace.yaml
```

Verify:

```bash
kubectl get namespaces
```

You should see:

```text
training-web
```

---

# Step 9 — Deploy the Application

Apply the Deployment:

```bash
kubectl apply -f kubernetes/01-deployment.yaml
```

Check:

```bash
kubectl get deployment -n training-web
```

Then:

```bash
kubectl get replicaset -n training-web
```

Then:

```bash
kubectl get pods -n training-web
```

Detailed view:

```bash
kubectl get pods -n training-web -o wide
```

The application flow is now:

```text
Deployment
    ↓
ReplicaSet
    ↓
+--------+--------+
|                 |
v                 v
Pod 1             Pod 2
```

---

# Step 10 — Create the Service

Apply:

```bash
kubectl apply -f kubernetes/02-service.yaml
```

Check:

```bash
kubectl get svc -n training-web
```

Describe:

```bash
kubectl describe svc training-web -n training-web
```

Check endpoints:

```bash
kubectl get endpoints -n training-web
```

The Service finds Pods using labels:

```text
Service
   |
   | selector
   | app=training-web
   |
   +--------+--------+
   |                 |
   v                 v
Pod 1             Pod 2
```

---

# Step 11 — Access the Application

Because this is a local laptop cluster, use port forwarding.

Run:

```bash
kubectl port-forward \
  -n training-web \
  svc/training-web \
  8080:80
```

Keep this terminal running.

Open the Windows browser:

```text
http://localhost:8080
```

Expected flow:

```text
Browser
   |
localhost:8080
   |
kubectl port-forward
   |
Service
   |
+--+--+
|     |
Pod1  Pod2
```

Stop port-forwarding with:

```text
Ctrl + C
```

---

# Step 12 — Self-Healing Demo

Check Pods:

```bash
kubectl get pods -n training-web
```

Delete one Pod:

```bash
kubectl delete pod <POD-NAME> -n training-web
```

Immediately watch:

```bash
kubectl get pods -n training-web -w
```

You should see Kubernetes create another Pod.

Why?

```text
Deployment Desired State = 2 Pods

One Pod Deleted
       ↓
Actual State = 1
       ↓
ReplicaSet detects mismatch
       ↓
New Pod Created
       ↓
Actual State = 2
```

Exit watch:

```text
Ctrl + C
```

---

# Step 13 — Scaling Demo

Check current Pods:

```bash
kubectl get pods -n training-web
```

Scale to four Pods:

```bash
kubectl scale deployment training-web \
  --replicas=4 \
  -n training-web
```

Verify:

```bash
kubectl get pods -n training-web
```

Detailed:

```bash
kubectl get pods -n training-web -o wide
```

Scale back to two:

```bash
kubectl scale deployment training-web \
  --replicas=2 \
  -n training-web
```

---

# Step 14 — Useful Troubleshooting Commands

Check all resources:

```bash
kubectl get all -n training-web
```

Describe Deployment:

```bash
kubectl describe deployment training-web -n training-web
```

Check Pods:

```bash
kubectl get pods -n training-web
```

Describe a Pod:

```bash
kubectl describe pod <POD-NAME> -n training-web
```

Logs:

```bash
kubectl logs <POD-NAME> -n training-web
```

Events:

```bash
kubectl get events -n training-web \
  --sort-by=.metadata.creationTimestamp
```

Service:

```bash
kubectl describe service training-web -n training-web
```

---

# Step 15 — Common Error: ImagePullBackOff

If you see:

```text
ImagePullBackOff
```

check:

```bash
kubectl describe pod <POD-NAME> -n training-web
```

For the local kind setup, verify the image exists:

```bash
docker images | grep k8s-training-web
```

Then load it again:

```bash
kind load docker-image k8s-training-web:v1 \
  --name k8s-training
```

Verify the Deployment uses:

```yaml
image: k8s-training-web:v1
```

and:

```yaml
imagePullPolicy: IfNotPresent
```

Then restart the Deployment:

```bash
kubectl rollout restart deployment training-web \
  -n training-web
```

---

# Step 16 — Cleanup Application

Delete the Kubernetes resources:

```bash
kubectl delete -f kubernetes/02-service.yaml
kubectl delete -f kubernetes/01-deployment.yaml
kubectl delete -f kubernetes/00-namespace.yaml
```

Or:

```bash
kubectl delete -f kubernetes/
```

Verify:

```bash
kubectl get all -n training-web
```

The kind Kubernetes cluster itself remains running.

---

# Student Practice Flow

Every student should practice this sequence:

```text
1. Verify Kubernetes cluster
              ↓
2. Clone GitHub repository
              ↓
3. Understand Dockerfile
              ↓
4. docker build
              ↓
5. docker run
              ↓
6. Test in browser
              ↓
7. Remove Docker container
              ↓
8. kind load docker-image
              ↓
9. kubectl apply Namespace
              ↓
10. kubectl apply Deployment
              ↓
11. Verify Deployment
              ↓
12. Verify ReplicaSet
              ↓
13. Verify Pods
              ↓
14. Create Service
              ↓
15. Port-forward
              ↓
16. Open browser
              ↓
17. Delete Pod — test self-healing
              ↓
18. Scale Deployment
              ↓
19. Check logs/events
              ↓
20. Cleanup
```

---

# Local vs Registry Deployment

## Local Laptop / kind

```text
docker build
     ↓
Local Image
     ↓
kind load docker-image
     ↓
Kubernetes
```

No Docker Hub required.

## Later — Multi-Server Kubernetes

```text
docker build
     ↓
Docker Hub / Amazon ECR
     ↓
Push Image
     ↓
Worker Nodes Pull Image
     ↓
Kubernetes
```

For this first application lab, students should use the **local image method**.

Docker Hub/ECR can be introduced later when moving from local kind to multi-node or cloud Kubernetes.

---

# Quick Commands

```bash
cd ~/Kubernetes/Kubernetes-Training/03-Applications/App-01-Nginx-Training-Web

docker build -t k8s-training-web:v1 .

docker run -d \
  --name nginx-test \
  -p 8080:80 \
  k8s-training-web:v1

curl http://localhost:8080

docker rm -f nginx-test

kind load docker-image k8s-training-web:v1 \
  --name k8s-training

kubectl apply -f kubernetes/

kubectl get deployment -n training-web
kubectl get rs -n training-web
kubectl get pods -n training-web -o wide
kubectl get svc -n training-web

kubectl port-forward \
  -n training-web \
  svc/training-web \
  8080:80
```

Open:

```text
http://localhost:8080
```

## Application Deployment Complete ✅

The student has now completed the complete local workflow:

```text
Code
 ↓
Docker Image
 ↓
Docker Container
 ↓
kind
 ↓
Kubernetes Deployment
 ↓
ReplicaSet
 ↓
Pods
 ↓
Service
 ↓
Browser
```
