# KolamCraft SQLite Database

This folder contains the optional local SQLite database setup for KolamCraft.

## Files

- `schema.sql`: SQLite schema for profiles, posts, likes, comments, saved designs, and canvas drafts.
- `init_sqlite.py`: Creates `kolamcraft.sqlite` from `schema.sql`.
- `kolamcraft.sqlite`: Generated local database file. It is ignored by Git.

## Create Or Refresh The Database

From the project root:

```bash
npm run db:init
```

This creates:

```text
database/kolamcraft.sqlite
```

## Credentials

SQLite does not use a username/password by default. The placeholders in `.env.example` are kept for a future backend/API layer that may sit in front of this file:

```env
DATABASE_URL=file:./database/kolamcraft.sqlite
DATABASE_USER=your_database_user_here
DATABASE_PASSWORD=your_database_password_here
DATABASE_SECRET=your_database_secret_here
```

Do not expose these as `VITE_` variables. `VITE_` values are bundled into the browser app.
