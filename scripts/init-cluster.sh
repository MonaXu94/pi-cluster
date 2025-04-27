#!/bin/bash

# Source the config file
source ./config/cluster_config.sh

# Initialize Master Nodes
# The first master node needs the --cluster-init flag
MASTER_IP="${MASTER_NODES[0]}"

# Initialize the first master node
echo "Initializing first Master Node: $MASTER_IP"
ssh -t $SSH_USER@$MASTER_IP "sudo curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - server --cluster-init --tls-san $LOAD_BALANCER_IP"
ssh -t $SSH_USER@$MASTER_IP "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml"
# Retrieve the k3s token from the first master node
MASTER_TOKEN=$(ssh -t $SSH_USER@$MASTER_IP "sudo cat /var/lib/rancher/k3s/server/node-token")

# Retrieve the kubeconfig and store it locally
ssh -t $SSH_USER@$MASTER_IP "touch /home/$SSH_USER/k3s.yaml"
ssh -t $SSH_USER@$MASTER_IP "sudo cat /etc/rancher/k3s/k3s.yaml > /home/$SSH_USER/k3s.yaml"
ssh -t $SSH_USER@$MASTER_IP "sed -i \"s|https://127.0.0.1:6443|https://${LOAD_BALANCER_IP}:${LOAD_BALANCER_PORT}|g\" /home/$SSH_USER/k3s.yaml"
scp $SSH_USER@$MASTER_IP:/home/$SSH_USER/k3s.yaml ./kubeconfig

# Initialize remaining Master Nodes
for MASTER in "${MASTER_NODES[@]:1}"; do
  echo "Initializing Master Node: $MASTER"
  ssh -t $SSH_USER@$MASTER "sudo curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - server --server https://$LOAD_BALANCER_IP:$LOAD_BALANCER_PORT --tls-san $LOAD_BALANCER_IP"
done

# Initialize Worker Nodes
for WORKER in "${WORKER_NODES[@]}"; do
  echo "Initializing Worker Node: $WORKER"

  # Get the token from the first master node to join the worker node
  ssh -t $SSH_USER@$WORKER "sudo curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - agent --server https://$LOAD_BALANCER_IP:$LOAD_BALANCER_PORT"
done

# Export kubeconfig for use
export KUBECONFIG=./kubeconfig
echo "Cluster initialized, kubeconfig saved at './kubeconfig'."
