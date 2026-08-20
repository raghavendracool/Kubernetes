# Student Web App

Bridge the Docker course into Kubernetes.

Build:

```bash
docker build -t <registry>/student-web:v1 .
```

Run:

```bash
docker run --rm -p 8080:8080   -e APP_ENV=docker   -e APP_MESSAGE="Hello Students"   <registry>/student-web:v1
```

Push to Docker Hub/ECR, then replace NGINX in later Kubernetes labs.
