# 5. EKS Add-ons

## List Installed Add-ons

```bash
aws eks list-addons \
  --cluster-name "$CLUSTER_NAME" \
  --region "$AWS_REGION"
```

Common core add-ons include:

- VPC CNI
- CoreDNS
- kube-proxy
- EKS Pod Identity Agent (when installed)
- EBS CSI Driver (when installed)

## Inspect Compatible Versions

```bash
aws eks describe-addon-versions \
  --kubernetes-version 1.36 \
  --region "$AWS_REGION" \
  --query 'addons[].{Addon:addonName,Versions:addonVersions[?compatibilities[?defaultVersion==`true`]].addonVersion}'
```

## Describe an Add-on

```bash
aws eks describe-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name coredns \
  --region "$AWS_REGION"
```

Before upgrades, verify add-on compatibility with the target Kubernetes version.
