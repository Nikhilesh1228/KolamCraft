PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS profiles (
  id TEXT PRIMARY KEY,
  email TEXT UNIQUE,
  username TEXT UNIQUE,
  avatar_url TEXT,
  bio TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS posts (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  user_id TEXT NOT NULL,
  title TEXT NOT NULL,
  image_url TEXT NOT NULL,
  likes_count INTEGER NOT NULL DEFAULT 0 CHECK (likes_count >= 0),
  comments_count INTEGER NOT NULL DEFAULT 0 CHECK (comments_count >= 0),
  complexity TEXT CHECK (complexity IN ('Beginner', 'Intermediate', 'Advanced')),
  grid_type TEXT,
  tags TEXT NOT NULL DEFAULT '[]',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS likes (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  post_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  UNIQUE(post_id, user_id),
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comments (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  post_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  text TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS saved_designs (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  post_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  UNIQUE(post_id, user_id),
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS canvas_drafts (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  user_id TEXT NOT NULL,
  title TEXT NOT NULL DEFAULT 'Untitled Kolam',
  canvas_data TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE
);

CREATE TRIGGER IF NOT EXISTS increment_likes_count
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
  UPDATE posts
  SET likes_count = likes_count + 1,
      updated_at = datetime('now')
  WHERE id = NEW.post_id;
END;

CREATE TRIGGER IF NOT EXISTS decrement_likes_count
AFTER DELETE ON likes
FOR EACH ROW
BEGIN
  UPDATE posts
  SET likes_count = CASE WHEN likes_count > 0 THEN likes_count - 1 ELSE 0 END,
      updated_at = datetime('now')
  WHERE id = OLD.post_id;
END;

CREATE TRIGGER IF NOT EXISTS increment_comments_count
AFTER INSERT ON comments
FOR EACH ROW
BEGIN
  UPDATE posts
  SET comments_count = comments_count + 1,
      updated_at = datetime('now')
  WHERE id = NEW.post_id;
END;

CREATE TRIGGER IF NOT EXISTS decrement_comments_count
AFTER DELETE ON comments
FOR EACH ROW
BEGIN
  UPDATE posts
  SET comments_count = CASE WHEN comments_count > 0 THEN comments_count - 1 ELSE 0 END,
      updated_at = datetime('now')
  WHERE id = OLD.post_id;
END;

CREATE TRIGGER IF NOT EXISTS update_profiles_timestamp
AFTER UPDATE ON profiles
FOR EACH ROW
BEGIN
  UPDATE profiles SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS update_posts_timestamp
AFTER UPDATE ON posts
FOR EACH ROW
BEGIN
  UPDATE posts SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS update_canvas_drafts_timestamp
AFTER UPDATE ON canvas_drafts
FOR EACH ROW
BEGIN
  UPDATE canvas_drafts SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE INDEX IF NOT EXISTS idx_posts_user_id ON posts(user_id);
CREATE INDEX IF NOT EXISTS idx_posts_created_at ON posts(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_likes_post_id ON likes(post_id);
CREATE INDEX IF NOT EXISTS idx_likes_user_id ON likes(user_id);
CREATE INDEX IF NOT EXISTS idx_comments_post_id ON comments(post_id);
CREATE INDEX IF NOT EXISTS idx_comments_created_at ON comments(created_at);
CREATE INDEX IF NOT EXISTS idx_saved_designs_user_id ON saved_designs(user_id);
CREATE INDEX IF NOT EXISTS idx_canvas_drafts_user_id ON canvas_drafts(user_id);
