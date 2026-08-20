# Mega Project Architecture Decisions

## Frontend
- Deployment
- ClusterIP Service
- readiness/liveness
- resources
- HPA
- PDB

## Backend
- Deployment
- Service
- ConfigMap/Secret
- ServiceAccount
- optional EKS Pod Identity

## Data
Use PostgreSQL for Kubernetes storage learning, but compare with a managed Amazon RDS design for real production.

## Traffic
- Ingress
- AWS Load Balancer Controller on EKS
- TLS

## Security
- least privilege RBAC
- NetworkPolicies
- non-root images
- no long-lived cloud keys in Pods
- image scanning
