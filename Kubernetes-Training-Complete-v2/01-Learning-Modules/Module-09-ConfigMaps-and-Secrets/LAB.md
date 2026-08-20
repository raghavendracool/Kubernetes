# Module 09 — ConfigMaps and Secrets: Hands-On Lab

## Objective
Inject configuration and Secret data without baking it into an image.

```bash
kubectl create namespace config-lab
kubectl create configmap app-config --from-literal=APP_ENV=training -n config-lab
kubectl create secret generic app-secret --from-literal=API_TOKEN='training-token' -n config-lab
```

Create a Pod that reads both objects:

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: env-demo
  namespace: config-lab
spec:
  restartPolicy: Never
  containers:
    - name: demo
      image: busybox:1.36
      command: ["sh","-c","env | sort; sleep 3600"]
      envFrom:
        - configMapRef:
            name: app-config
        - secretRef:
            name: app-secret
EOF

kubectl wait --for=condition=Ready pod/env-demo -n config-lab --timeout=120s
```

Then:

```bash
kubectl exec -n config-lab env-demo -- env | sort
kubectl get secret app-secret -n config-lab -o jsonpath='{.data.API_TOKEN}' | base64 -d; echo
```

Explain why base64 is not encryption.

```bash
kubectl delete namespace config-lab
```
