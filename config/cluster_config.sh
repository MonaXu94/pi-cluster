#!/bin/bash

# Configurations for the master and worker nodes
MASTER_NODES=("192.168.1.101" "192.168.1.102" "192.168.1.103")
WORKER_NODES=("192.168.1.104")

# SSH User Configuration
SSH_USER="david"

# Load Balancer Configuration
LOAD_BALANCER_IP="192.168.1.229"
LOAD_BALANCER_PORT="6443"
