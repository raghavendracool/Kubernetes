# Module 11 — Storage: Volumes, PV, PVC and StorageClass: Hands-On Lab

## Objective
Inspect dynamic storage behavior. This lab requires a default StorageClass; otherwise use it as a diagnostic exercise.

```bash
kubectl create namespace storage-lab
kubectl get storageclass
kubectl apply -n storage-lab -f examples/pvc.yaml
kubectl get pvc -n storage-lab -w
kubectl describe pvc demo-data -n storage-lab
```

If PVC becomes Bound:

```bash
kubectl get pv
```

Create a Pod that mounts the claim:

```bash
cat <<'EOF' | kubectl apply -n storage-lab -f -

apiVersion: v1
kind: Pod
metadata:
  name: writer
spec:
  containers:
  - name: writer
    image: busybox:1.36
    command: ["sh","-c","echo persistent-data > /data/test.txt; sleep 3600"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: demo-data
EOF
```

Verify the file:

```bash
kubectl wait --for=condition=Ready pod/writer -n storage-lab --timeout=120s
kubectl exec -n storage-lab writer -- cat /data/test.txt
```

Delete and recreate the Pod with the same PVC, then prove the data still exists:

```bash
kubectl delete pod writer -n storage-lab
cat <<'EOF' | kubectl apply -n storage-lab -f -
apiVersion: v1
kind: Pod
metadata:
  name: reader
spec:
  containers:
  - name: reader
    image: busybox:1.36
    command: ["sh","-c","cat /data/test.txt; sleep 3600"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: demo-data
EOF
kubectl wait --for=condition=Ready pod/reader -n storage-lab --timeout=120s
kubectl exec -n storage-lab reader -- cat /data/test.txt
```

This demonstrates that the data lifetime is tied to the persistent volume, not the Pod.

```bash
kubectl delete namespace storage-lab
```
