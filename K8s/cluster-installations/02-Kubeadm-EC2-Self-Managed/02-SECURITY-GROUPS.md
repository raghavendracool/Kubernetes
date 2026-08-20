# 02 — Security Groups

Do not teach `All traffic 0.0.0.0/0` as the solution.

Important control-plane ports:
- TCP 6443 — API Server
- TCP 2379-2380 — etcd
- TCP 10250 — kubelet API
- TCP 10257 — controller-manager
- TCP 10259 — scheduler

Worker concepts:
- TCP 10250 — kubelet
- TCP/UDP 30000-32767 — default NodePort range when required

Course pattern:
- SSH 22 only from student/instructor IP.
- 6443 from approved admin IP plus required internal cluster sources.
- Internal cluster traffic between training-node SG members as required.
- Open NodePort only for specific labs.
