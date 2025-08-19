# CI/CD with GitHub Actions → Docker Hub → Kubernetes (K3s/Minikube)

This starter shows a full pipeline:
1) Build & test a Python Flask app
2) Build & push a Docker image to Docker Hub
3) Deploy to a remote Kubernetes cluster (K3s/Minikube) via SSH

## Prerequisites
- Kubernetes cluster (K3s on a t2.micro is fine)
- Docker Hub account + a repository named `ci-cd-demo`
- GitHub repository (push this code there)
- An SSH-accessible user on the cluster node with `kubectl` access

## Required GitHub Secrets
- `DOCKERHUB_USERNAME`: your Docker Hub username
- `DOCKERHUB_TOKEN`: a Docker Hub access token (create in Docker Hub → Security)
- `SSH_HOST`: public IP or DNS of your cluster node (e.g. EC2)
- `SSH_USER`: username (e.g. `ubuntu` for Ubuntu AMI, or `ec2-user` for Amazon Linux)
- `SSH_KEY`: **contents** of your private SSH key (paste the text, including `-----BEGIN ...`)

Optional:
- Open security group port `30080` for testing the NodePort service externally.

## First-time cluster prep (on the node)
```bash
# install K3s (if not installed)
curl -sfL https://get.k3s.io | sh -

# kubeconfig for your user
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
export KUBECONFIG=~/.kube/config
```

## Test after deploy
```bash
kubectl -n demo get pods,svc
curl http://<NODE-IP>:30080/
```

## Rollback
```bash
kubectl -n demo rollout undo deploy/demo
```
