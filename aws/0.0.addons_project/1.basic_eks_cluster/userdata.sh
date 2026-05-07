# filename: userdata.sh
#!/bin/bash
set -e

echo "Updating packages"
sudo apt-get update -y

echo "Installing unzip and curl"
sudo apt-get install -y unzip curl

echo "Installing kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Installing AWS CLI v2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Updating kubeconfig for EKS cluster"
aws eks update-kubeconfig --region us-east-1 --name devops-cluster

echo "Bootstrap complete. Now we can run kubectl commands."

echo "Varifying the cluster access"
kubectl get nodes
kubectl get pods