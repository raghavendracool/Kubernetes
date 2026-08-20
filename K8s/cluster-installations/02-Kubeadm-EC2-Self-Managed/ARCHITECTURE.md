# Architecture

```text
AWS VPC
│
├── Control Plane EC2
│   ├── kube-apiserver
│   ├── etcd
│   ├── scheduler
│   ├── controller-manager
│   ├── kubelet
│   └── containerd
│
├── Worker-01
│   ├── kubelet
│   ├── containerd
│   ├── Calico
│   └── Pods
│
└── Worker-02
    ├── kubelet
    ├── containerd
    ├── Calico
    └── Pods
```

In this track **you manage the entire Kubernetes cluster**.
