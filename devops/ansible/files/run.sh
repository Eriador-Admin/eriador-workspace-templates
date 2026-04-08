#!/bin/bash
set -e
echo "Running {{PROJECT_NAME}} playbook..."
ansible-playbook -i inventory/hosts.yml site.yml
