# {{APP_NAME}} — Social Network Database

## Agent Guidelines
- This is a **database-only** template (SQL schemas + seed data).
- Vendor chosen at scaffold time: **{{DB_VENDOR}}**.
- Run `bash init.sh` to apply schema and seed data.
- Tables: users, friendships, posts, comments, likes, messages, notifications.
- Friendship statuses: pending, accepted, blocked.
- Post visibility: public, friends, private.
- Likes are polymorphic (target_type: post or comment).
- Notifications cover: like, comment, follow_request, follow_accept, mention, message.
- Oracle uses `likes_tbl` instead of `likes` (reserved word).
