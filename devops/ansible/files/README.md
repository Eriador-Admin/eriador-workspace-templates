# {{PROJECT_NAME}}

Infrastructure automation with [Ansible](https://www.ansible.com/).

## Getting Started

```bash
bash init.sh    # install Ansible
bash run.sh     # run the site playbook
bash stop.sh    # (no-op — Ansible is agentless)
```

## Project Structure

```
inventory/
  hosts.yml         # Inventory of target hosts
group_vars/
  all.yml           # Variables for all hosts
  webservers.yml    # Variables for webservers group
roles/
  common/           # Base server setup role
    tasks/main.yml
    handlers/main.yml
    templates/
  webserver/        # Nginx web server role
    tasks/main.yml
    handlers/main.yml
    templates/nginx.conf.j2
site.yml            # Main playbook
ansible.cfg         # Ansible configuration
```

## Usage

```bash
# Run full playbook
ansible-playbook -i inventory/hosts.yml site.yml

# Run only webserver role
ansible-playbook -i inventory/hosts.yml site.yml --tags webserver

# Dry run
ansible-playbook -i inventory/hosts.yml site.yml --check

# Run against specific host
ansible-playbook -i inventory/hosts.yml site.yml --limit web1
```

## Requirements

- Python 3.10+
- Ansible 2.16+
