#!/bin/bash

# Source the config file to load the IPs
source ./config/cluster_config.sh

# Temporary folder where kubeconfig is stored
KUBECONFIG_DIR="./kubeconfig"

# Remove worker nodes from the cluster
IFS=',' read -ra WORKER_NODES <<< "$WORKER_IPS"
for WORKER_IP in "${WORKER_NODES[@]}"; do
  echo "Removing worker node at $WORKER_IP..."
  ssh $SSH_USER@$WORKER_IP "sudo su && /usr/local/bin/k3s-agent-uninstall.sh"
  if [ $? -ne 0 ]; then
    echo "Failed to remove worker node at $WORKER_IP"
  else
    echo "Successfully removed worker node at $WORKER_IP"
  fi
done

# Uninstall k3s from the master node
echo "Uninstalling k3s from master node at $MASTER_IP..."
ssh $SSH_USER@$MASTER_IP "sudo su && /usr/local/bin/k3s-uninstall.sh"
if [ $? -ne 0 ]; then
  echo "Failed to uninstall k3s from master node"
  exit 1
else
  echo "Successfully uninstalled k3s from master node"
fi

# Cleanup: Remove the kubeconfig file and temporary folder
echo "Cleaning up kubeconfig..."
rm -rf "$KUBECONFIG_DIR"

# Optionally, you can remove your Terraform-managed infrastructure
# terraform destroy -auto-approve

echo "Cluster destruction complete."
