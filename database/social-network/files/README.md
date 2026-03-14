# {{APP_NAME}}

Social Network database schema for **{{DB_VENDOR}}**.

## Quick Start

```bash
bash init.sh
```

## Tables

| Table | Purpose |
|-------|---------|
| users | User profiles (username, email, bio, avatar) |
| friendships | Bidirectional friend/follow relationships |
| posts | User-authored posts with media support |
| comments | Threaded comments on posts |
| likes | Polymorphic likes on posts & comments |
| messages | Direct messages between users |
| notifications | Activity notifications |

## Post Visibility

`public` · `friends` · `private`

## Friendship Status

`pending` → `accepted` (or `blocked`)
