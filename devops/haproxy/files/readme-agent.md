# Agent Instructions — {{PROJECT_NAME}}

This is an HAProxy load balancer project.

## Tech Stack
- **Load Balancer**: HAProxy 2.9
- **Backend**: Sample Node.js containers
- **Infrastructure**: Docker Compose

## Key Conventions
- Config in `haproxy/haproxy.cfg`
- Sections: global, defaults, frontend, backend, listen
- ACLs for path-based routing
- Stats dashboard on port 8404
- Algorithms: roundrobin, leastconn, source, uri
- Health checks via `option httpchk`
- Reload without downtime: `docker kill -s HUP <container>`
