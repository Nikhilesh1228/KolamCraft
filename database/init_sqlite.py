from pathlib import Path
import sqlite3


ROOT = Path(__file__).resolve().parent
DATABASE_PATH = ROOT / "kolamcraft.sqlite"
SCHEMA_PATH = ROOT / "schema.sql"


def main() -> None:
    schema = SCHEMA_PATH.read_text(encoding="utf-8")
    with sqlite3.connect(DATABASE_PATH) as connection:
        connection.executescript(schema)
        connection.execute("PRAGMA foreign_keys = ON")

    print(f"SQLite database ready: {DATABASE_PATH}")


if __name__ == "__main__":
    main()
