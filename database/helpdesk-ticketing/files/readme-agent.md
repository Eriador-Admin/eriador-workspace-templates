# {{APP_NAME}} — Helpdesk Ticketing Database

## Agent Guidelines
- This is a **database-only** template (SQL schemas + seed data).
- Vendor chosen at scaffold time: **{{DB_VENDOR}}**.
- Run `bash init.sh` to apply schema and seed data.
- Tables: departments, agents, customers, ticket_categories, sla_policies, tickets, ticket_messages, ticket_attachments.
- Ticket lifecycle: open → in_progress → waiting → resolved → closed.
- Priority levels: critical, high, medium, low.
- Channels: web, email, phone, chat, api.
- Agents have roles: admin, supervisor, agent.
- SLA policies define first-response and resolution targets.
