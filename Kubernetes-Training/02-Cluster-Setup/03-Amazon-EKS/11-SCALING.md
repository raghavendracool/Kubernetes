# 11. Scaling in EKS

There are two different scaling questions:

```text
HPA -> Do I need more/fewer Pods?
Node autoscaler / Karpenter / EKS Auto Mode -> Do I need more/fewer nodes/capacity?
```

## Managed Node Group Limits

```bash
eksctl get nodegroup --cluster "$CLUSTER_NAME" --region "$AWS_REGION"
```

Example scaling update:

```bash
eksctl scale nodegroup \
  --cluster "$CLUSTER_NAME" \
  --name app-ng \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 5 \
  --region "$AWS_REGION"
```

For production, choose one capacity-management strategy deliberately. Avoid installing multiple autoscaling systems that fight over the same nodes.
