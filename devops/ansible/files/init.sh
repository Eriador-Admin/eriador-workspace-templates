#!/bin/bash
set -e
echo "Installing Ansible..."
pip3 install ansible --quiet 2>/dev/null || pip install ansible --quiet
echo "Verifying..."
ansible --version
echo "Done! Update inventory/hosts.yml with your target hosts."
