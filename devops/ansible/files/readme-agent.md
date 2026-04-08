# Agent Instructions — {{PROJECT_NAME}}

This is an Ansible infrastructure automation project.

## Tech Stack
- **Automation**: Ansible
- **Language**: YAML + Jinja2 templates

## Key Conventions
- Main playbook: `site.yml`
- Inventory in `inventory/hosts.yml`
- Group variables in `group_vars/`
- Roles in `roles/` following standard Ansible structure
- Jinja2 templates use `.j2` extension
- Config in `ansible.cfg`
