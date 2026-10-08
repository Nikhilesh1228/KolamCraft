# KolamCraft

KolamCraft is a React + Vite web app for creating, exploring, and sharing digital Kolam designs. It includes an interactive drawing canvas with dot grids, symmetry modes, shapes, fill, eraser, undo/redo, PNG/PDF export, and a community-style explore/profile experience.

The app works in two modes:

- **Local mode**: no backend required. Authentication, posts, comments, and uploads use browser storage.
- **Supabase mode**: optional cloud authentication, database tables, storage, and realtime post updates.

Live site: [kolamcraft.netlify.app](https://kolamcraft.netlify.app/)

## Features

- Interactive Kolam canvas with rectangular, triangular, circular, and blank grids.
- Drawing tools for lines, curves, freehand strokes, shapes, erasing, and fills.
- Symmetry helpers for vertical, horizontal, and radial patterns.
- Undo/redo history for strokes, fills, and eraser actions.
- Export designs as PNG or PDF, including the visible grid/reference layer.
- Explore page with searchable design cards, filters, likes, comments, and practice links.
- Profile page showing the current user's local or Supabase-backed posts.
- Optional Supabase integration for persistent auth, posts, comments, likes, and image storage.

## Tech Stack

- React 18
- Vite 6
- TypeScript
- Tailwind-style utility CSS
- Radix UI components
- Lucide React icons
- Supabase JS client
- jsPDF for PDF export

## Project Structure

```text
.
├── index.html
├── package.json
├── vite.config.ts
├── supabase-schema.sql
├── src/
│   ├── App.tsx
│   ├── main.tsx
│   ├── components/
│   │   ├── CanvasPage.tsx
│   │   ├── ExplorePage.tsx
│   │   ├── ProfilePage.tsx
│   │   └── ui/
│   ├── contexts/
│   │   └── AuthContext.tsx
│   ├── data/
│   │   └── exploreDesigns.ts
│   ├── utils/
│   │   ├── dataStore.ts
│   │   └── supabase/
│   └── assets/
└── .env.example
```

## Getting Started

### 1. Install dependencies

```bash
npm install
```

### 2. Start the app

```bash
npm run dev
```

Vite is configured to run at:

```text
http://localhost:3000
```

### 3. Try local mode

Local mode works without a `.env` file.

- Sign in with any username and a password of at least 6 characters.
- Or use **Continue as Demo User** on the sign-in/register screens.
- Data is stored in your browser with `localStorage`.

## Optional Supabase Setup

Use Supabase only if you want cloud auth, persistent community data, and image storage.

### 1. Create a Supabase project

Create a project in the [Supabase dashboard](https://supabase.com/dashboard).

### 2. Configure environment variables

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

On Windows PowerShell:

```powershell
Copy-Item .env.example .env
```

Fill in:

```env
VITE_SUPABASE_PROJECT_ID=your_project_id_here
VITE_SUPABASE_ANON_KEY=your_anon_key_here
```

The project ID is the short reference in your Supabase URL:

```text
https://YOUR_PROJECT_ID.supabase.co
```

### 3. Create tables and storage

Open Supabase SQL Editor and run the contents of:

```text
supabase-schema.sql
```

That file creates the profiles, posts, likes, comments, triggers, indexes, row-level security policies, and the public `kolams` storage bucket.

### 4. Restart Vite

Stop and restart the dev server after changing `.env`:

```bash
npm run dev
```

## Available Scripts

```bash
npm run dev
```

Starts the development server.

```bash
npm run build
```

Creates the production build in `dist/`.

## Deployment

The app is configured for static hosting.

For Netlify:

- Build command: `npm run build`
- Publish directory: `dist`
- Add `VITE_SUPABASE_PROJECT_ID` and `VITE_SUPABASE_ANON_KEY` in site environment variables if using Supabase.

## Troubleshooting

- **Blank Supabase data**: confirm `.env` values are correct and restart Vite.
- **Auth works locally but not in Supabase mode**: check Supabase Auth settings and confirm `supabase-schema.sql` has run successfully.
- **Image uploads fail**: confirm the `kolams` storage bucket and storage policies exist.
- **Dev server opens the wrong port**: this project uses port `3000` in `vite.config.ts`.
- **Local test data looks stale**: clear browser storage for the site, then refresh.

## Verification

Current maintenance checks:

```bash
npm audit --audit-level=moderate
npm run build
```

Both should complete without reported vulnerabilities or build errors.
