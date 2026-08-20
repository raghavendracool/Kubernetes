# 12. EKS Security Checklist

## Identity

```bash
aws eks list-access-entries --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
kubectl auth can-i --list
```

## Network

- Decide whether public API endpoint access is required.
- Restrict public endpoint CIDRs when used.
- Use private endpoints for private administration patterns where appropriate.
- Use Security Groups and NetworkPolicy as complementary controls.

## Workload Identity

Use EKS Pod Identity or IRSA for AWS API access from Pods. Do not put AWS access keys in Secrets/environment variables for long-lived workload authentication.

## Pods

```bash
kubectl get ns --show-labels
kubectl get networkpolicy -A
kubectl get role,rolebinding -A
```

Apply non-root, seccomp, capability dropping and controlled images based on workload compatibility.
