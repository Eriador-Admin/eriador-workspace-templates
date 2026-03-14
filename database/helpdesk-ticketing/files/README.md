# {{APP_NAME}}

Helpdesk Ticketing database schema for **{{DB_VENDOR}}**.

## Quick Start

```bash
bash init.sh
```

## Tables

| Table | Purpose |
|-------|---------|
| departments | Organisational departments |
| agents | Support staff / agents |
| customers | Ticket-raising customers |
| ticket_categories | Nested category taxonomy |
| sla_policies | First-response & resolution targets |
| tickets | Core ticket records |
| ticket_messages | Threaded conversation per ticket |
| ticket_attachments | File attachments on tickets/messages |

## Ticket Lifecycle

`open` → `in_progress` → `waiting` → `resolved` → `closed`

## Priority Levels

critical · high · medium · low

## Channels

web · email · phone · chat · api
